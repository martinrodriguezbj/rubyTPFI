class ProfilesController < ApplicationController

    def show
        #obtener el usuario logeado actualmente
        id = Current.user.id
        #obtener el usuario correspondiente al id
        @user = User.find(id)
    end

end