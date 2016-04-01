class QuestionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource param_method: :my_sanitizer
  before_action :load_resource, only: [:new, :create, :edit, :update]

  def new
    @question.question_options.build 
  end

  def create
    if @question.save
      current_user.activities.create target_id: @question.id, 
        action_type: "question_activities"
      flash[:success] = t "question.success_created" 
      redirect_to root_path      
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes my_sanitizer
      current_user.activities.first_or_create target_id: @question.id,
        action_type: "question_activities"      
      flash[:success] = t "question.updated"
      redirect_to root_path
    else
      load_resource
      render :edit
    end
  end

  def destroy 
    if @question.destroy      
      flash[:success] = t "question.deleted"      
    else
      flash[:danger] = t "question.can_not_delete"     
    end
    redirect_to root_path
  end

  private
  def my_sanitizer
    params.require(:question).permit :content, :option_type, :status, :user_id, :category_id,
      question_options_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_resource
    @categories = Category.all
    @option_type = @question.option_type ||= Settings.question_option_type.default
    @status = @question.status ||= Settings.question_status_default.user
  end
end
