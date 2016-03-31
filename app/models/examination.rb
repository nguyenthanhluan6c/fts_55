class Examination < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy  
  has_many :questions, through: :results

  accepts_nested_attributes_for :results

  enum status: {testing: 0, uncheck: 1, checked: 2}

  after_create :init_exam

  def time_remaining
    category.time_limit  - self.spent_time
  end

  def time_spent
    self.spent_time + (Time.zone.now - self.updated_at).to_i
  end

  private
  def init_exam
    number = category.number_of_questions_in_examination   
    questions = category.questions.order("RANDOM()").limit number
    questions.each do |question|
      results.create question: question     
    end     
  end
end
