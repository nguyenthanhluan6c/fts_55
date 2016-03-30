class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :examination, through: :results
  has_many :question_options, dependent: :destroy

  accepts_nested_attributes_for :question_options, allow_destroy: true

  validates_presence_of :content
  validate :at_least_one_right_question_option
  validate :single_choice_question_option

  enum option_type: {single_choice: 0, multi_choice: 1, text: 2}
  enum status: {waiting: 0, approved: 1, rejected: 2}

  private
  def at_least_one_right_question_option
    valid = false
    if option_type_changed?
      question_options.each do |option|  
        option.mark_for_destruction unless option.new_record?
        valid = option.is_correct? ? true : valid if  option.new_record?
    end
    else
      question_options.each do |option|     
        valid = option.is_correct? ? true : valid unless option.marked_for_destruction?
      end
    end
    errors.add :question_options, I18n.t("at_least_1_right") unless valid
  end

  def single_choice_question_option
    if single_choice?
      count_right = 0
      if option_type_changed?
        question_options.each do |option|  
          count_right+=1 if option.new_record? && option.is_correct?
        end
      else
        question_options.each do |option|     
          count_right+=1 if option.marked_for_destruction? == false && option.is_correct? 
        end
      end
      errors.add :question_options, I18n.t("only_1_right") unless count_right == 1
    end
  end
end
