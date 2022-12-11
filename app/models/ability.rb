# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :Cliente
      #permisos de leer en bank
      can :read, Bank

      #permitir acceso a profile
      can :read, :show
      #permitir crear nuevo turno
      can :create, :Turn
      #permitir editar sus turnos
      can :edit, :edit
      #permitir ver sus turnos
      can :read, :past_turns
      can :read, :future_turns
      #permitir eliminar sus turnos
      can :delete, :destroy
    elsif user.has_role? :"Personal bancario"
      can :read, Bank
      can :read, User

      can :edit, User

      can :read, :show
      #permitirle ver index_client
      can :read, :index_client

      #permitirle atender turno
      can :update, :attend

      #permitirle ver turnos
      can :read, :index
    elsif user.has_role? :Administrador
      can :manage, Bank
      can :manage, User
      can :read, :show
      can :manage, Locality
      can :edit, :editSchedule
      can :update, :updateSchedule
    end

    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
