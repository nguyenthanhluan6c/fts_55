class QuestionOption < ActiveRecord::Base
  belongs_to :question

  has_many :results_options
end
