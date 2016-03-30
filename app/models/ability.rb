class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :update, User, id: user.id
      can [:create, :read, :update], Examination
      can :index, Category
      can [:create, :index, :edit, :update], Question, user_id: user.id
    end
  end
end
