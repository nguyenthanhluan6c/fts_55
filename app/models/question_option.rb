class QuestionOption < ActiveRecord::Base
  belongs_to :question

  has_many :results_options
  
  validates_presence_of :content

  scope :correct, ->{where is_correct: true}
end
