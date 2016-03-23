class Category < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :examinations, dependent: :destroy

  validates_numericality_of :number_of_words_in_examination, greater_than: 0
  validates_presence_of :name
end
