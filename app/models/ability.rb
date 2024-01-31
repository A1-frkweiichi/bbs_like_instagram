class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post

    return unless user.present?
    can :manage, Post, user_id: user.id

    return unless user.is_admin?
    can :manage, Post
  end
end

