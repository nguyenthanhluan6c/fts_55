class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :examination, through: :results
  has_many :question_options, dependent: :destroy
end
