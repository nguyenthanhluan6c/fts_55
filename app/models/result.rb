class Result < ActiveRecord::Base
  belongs_to :question
  belongs_to :examination

  serialize :content, Array
end
