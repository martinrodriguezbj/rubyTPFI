class ProfilesController < ApplicationController
    load_and_authorize_resource :class => ProfilesController
    skip_authorize_resource
    def show
        #obtener el usuario logeado actualmente
        id = Current.user.id
        #obtener el usuario correspondiente al id
        @user = User.find(id)
        authorize! :do_this, :on_this
    end

end