class Examination < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy  
  has_many :questions, through: :results
end
