class Examination < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy  
  has_many :questions, through: :results

  accepts_nested_attributes_for :results

  enum status: {testing: 0, uncheck: 1, checked: 2}

  after_create :init_exam

  def time_remaining
    category.time_limit  - time_spent
  end

  def time_spent
    self.spent_time + (Time.zone.now - self.updated_at).to_i
  end

  def auto_check
    self.results.includes(question: :question_options).each do |result|
      question = result.question
      if question.text?
        is_correct = question.question_options.first.content == result.content[0] ? 
          true : false
        result.update_attributes is_correct: is_correct
      else
        is_correct = (result.question.question_options.correct.ids.map{|id| id.to_s} - 
          result.content).empty? ? true: false
        result.update_attributes is_correct: is_correct
      end
    end
  end

  def caculate_score
    update_attributes number_of_right_answer: results.correct.count
  end

  def send_exam_result
    ExaminationResultSenderWorker.perform_async self.id
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
