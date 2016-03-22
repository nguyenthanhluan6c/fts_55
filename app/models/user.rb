class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable

  has_many :examinations, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :questions, dependent: :destroy
end
