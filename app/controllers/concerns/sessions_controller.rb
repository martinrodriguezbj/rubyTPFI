class SessionsController < ApplicationController
  #before action lo tuve que sacar xq no me dejaba deslogearme
  #before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :protect_pages
    
    # GET /users/new
    def new
      if Current.user
        raise ActionController::RoutingError.new('Not Found')
      end
    end
  
    # POST /users
    def create
      #buscar usuario si el username es igual :login
        @user = User.find_by("username = :login OR username = :login", {login: params[:login]})
        if @user&.authenticate(params[:password_digest])
          session[:user_id] = @user.id
          redirect_to banks_url, notice: "login successfully"            
        else
          redirect_to new_session_path, alert: "login failed"
        end
    end

    def destroy
      session.delete(:user_id)
      redirect_to new_session_path , notice: "logout successfully"
    end
  end