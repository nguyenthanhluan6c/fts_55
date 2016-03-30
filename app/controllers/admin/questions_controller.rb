class Admin::QuestionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource param_method: :my_sanitizer
  before_action :load_resource, only: [:new, :create, :edit, :update]

  def index
    @questions = @questions.page params[:page]
  end

  def new
    @question.question_options.build 
  end

  def create
    if @question.save
      flash[:success] = t "question.success_created" 
      redirect_to admin_questions_path      
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes my_sanitizer      
      flash[:success] = t "question.updated"
      redirect_to admin_questions_path
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
    redirect_to admin_questions_path
  end

  private
  def my_sanitizer
    params.require(:question).permit :content, :option_type, :status, :user_id, :category_id,
      question_options_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_resource
    @categories = Category.all
    @option_type = @question.option_type ||= Settings.question_option_type.default
    @status = @question.status ||= Settings.question_status_default.admin
  end
end
