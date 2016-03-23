class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      cannot :manage, @Category
      if user.mod?     
        can :update, @Question
      end
    end
  end
end
