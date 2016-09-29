class Ability
  include CanCan::Ability

  def initialize user, namespace
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    else
      if namespace == "admin"
        cannot :manage, :all
      end
      can :read, :all
      can :update, [Result, Lesson]
      can :create, Lesson
    end
  end
end
