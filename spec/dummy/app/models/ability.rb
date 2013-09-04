class Ability
  include CanCan::Ability

  def initialize(user)
    if user.respond_to?(:super_admin?) && user.super_admin?
      can :manage, :all
    else
      can :read, ActiveAdmin::Page, name: "Dashboard"
      can [:read, :show, :index], [Category, Post]
    end
  end
end
