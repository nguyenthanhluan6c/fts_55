class ExaminationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource param_method: :my_sanitizer

  def create
    @category = Category.find my_sanitizer[:category_id]
    @examination = current_user.examinations.build category: @category, status: "testing"  
    if @examination.save
      current_user.activities.create target_id: @examination.id,
        action_type: "examination_activities"      
      redirect_to @examination
    else
      flash[:danger] = t "examination.can_not_take_examination"
      redirect_to root_url
    end     
  end

  def show   
    @results = @examination.results
    @time_remaining = @examination.time_remaining 
  end
  
  def update
    if @examination.update_attributes my_sanitizer
      if ["Save", "Finish"].include? params[:commit]
        @examination.update_attributes status: "uncheck" 
        @examination.auto_check
        current_user.activities.first_or_create target_id: @examination.id,
          action_type: "examination_activities"
      elsif params[:commit] == "Save checking"
        @examination.update_attributes status: "checked"
        @examination.caculate_score
        @examination.send_exam_result
        current_user.activities.first_or_create target_id: @examination.id,
          action_type: "examination_activities"
      end  
      redirect_to root_path
    else
      flash[:danger] = t "examination.can_not_update"
      redirect_to categories_path
    end
  end

  private
  def my_sanitizer
    params.require(:examination).permit :id, :status, :user_id, :category_id,
      results_attributes: [:id, :is_correct, :examination_id, :question_id, content: []]
  end
end
