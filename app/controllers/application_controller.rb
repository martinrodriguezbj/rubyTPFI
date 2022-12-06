class ApplicationController < ActionController::Base

    #callback 
    before_action :set_current_user
    before_action :protect_pages

    def set_current_user
       Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def protect_pages
        redirect_to new_session_path, notice: "You must be logged in" unless Current.user
    end

    # redefino current ability por que ability.new esperaba un Current_user y no un current.
    def current_ability
    @current_ability ||= Ability.new(Current.user)
    end

    #redefino excepcion de cancan
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to banks_url, :alert => exception.message
    end
end
