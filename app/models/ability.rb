class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new()
    #@user.roles.each { |role| send(role.name.downcase) }

    if user.has_role? :admin
      can :manage, :all
    end 

    #if @user.roles.size == 0
    #  can :read, :all #for guest without roles
    #end
  end 

    #can :manage, :all if user.try(:admin?)

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  
    # def subscriber
    #   puts "subs"
    #   can [:read, :edit], User, :user_id => @user.id
    # end
    #
    # def admin
    #   puts 'amdin'
    #   can :manage, User 
    # end
end
