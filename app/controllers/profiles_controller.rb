class ProfilesController < ApplicationController
    load_and_authorize_resource :class => ProfilesController
    skip_authorize_resource
    def show
        #obtener el usuario logeado actualmente
        id = Current.user.id
        #obtener el usuario correspondiente al id
        @user = User.find(id)
        authorize! :read, :show
    end

    def edit
        id = Current.user.id
        @user = User.find(id)
    end

    def update
        id = Current.user.id
        @user = User.find(id)
        if @user.update(user_params)
            redirect_to profiles_path
        else
            render 'edit'
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end