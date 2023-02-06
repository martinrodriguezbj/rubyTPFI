# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :Cliente
      can :read, Bank
      can :read, :showProfile
      can :read, :showTurn
      can :create, :Turn
      can :edit, :editTurn
      can :read, :past_turns
      can :read, :future_turns
      can :delete, :destroyTurn
    elsif user.has_role? :"Personal bancario"
      can :read, :showProfile
      can :read, Bank
      can :read, User
      can :edit, User
      can :read, :showTurn
      can :read, :index_client
      can :update, :attend
      #permitirle ver turnos
      can :read, :index
    elsif user.has_role? :Administrador
      can :read, :showProfile
      can :manage, Bank
      can :read, :indexUsers
      can :read, :User
      can :create, :User
      can :edit, :User
      can :delete, :User
      can :manage, Locality
      can :edit, :editSchedule
      can :update, :updateSchedule
    end
    
  end
end
