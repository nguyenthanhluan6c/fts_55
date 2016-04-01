class Activity < ActiveRecord::Base
  belongs_to :user

  enum action_type: {examination_activities: 0, question_activities: 1}

  scope :can_see_by_user, ->(user){
    where user_id: User.can_manage(user)
  }

  def object
    return Examination.find_by id: target_id if examination_activities?
    return Question.find_by id: target_id if question_activities?
  end

  def action
    return "Examination" if examination_activities?
    return "Contribute question"if question_activities?
  end

  def object_name
    object.category.name if object.present?
  end

  def object_status
    object.status if object.present?
  end
end
