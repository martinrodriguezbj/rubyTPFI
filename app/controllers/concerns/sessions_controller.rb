class SessionsController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]
  
    # GET /users/new
    def new
    end
  
    # POST /users
    def create
      #buscar usuario si el username es igual :login
        @user = User.find_by("username = :login OR username = :login", {login: params[:login]})
        if @user&.authenticate(params[:password])
            redirect_to @bank, notice: "login successful"
            
        else

        end
      #@user = User.new(user_params)
  
      #if @user.save
      # redirect_to @user, notice: "User was successfully created."
      #else
      #  render :new, status: :unprocessable_entity
      #end
    end
  
  
      # Only allow a list of trusted parameters through.
      #def user_params
      #  params.require(:user).permit(:username, :password, :roll)
      #end
  end