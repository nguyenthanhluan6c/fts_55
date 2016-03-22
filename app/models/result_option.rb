class ResultOption < ActiveRecord::Base
  belongs_to :question_option
  belongs_to :result
end
