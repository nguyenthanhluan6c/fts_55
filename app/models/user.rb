class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable

  has_many :examinations, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :questions, dependent: :destroy

  enum role: {normal: 0, admin: 1, mod: 2}

  scope :can_manage, ->(user){
    return where("") if user.admin?
    return where(id: [User.where(role: "normal").ids, user.id]) if user.mod?
    return where(id: user.id) if user.normal?
    }  

  def feed
    return Activity.can_see_by_user(self).order "created_at desc"
  end
end
