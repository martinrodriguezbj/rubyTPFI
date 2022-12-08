class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_authorize_resource

  def newCliente
    @user = User.new
    print("ENTREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE")
  end

  def createCliente
    print("VOLVIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII")
    @user = User.new(user_params)
    @user.add_role("Cliente")
    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :newCliente, status: :unprocessable_entity
    end
  end


  # GET /users
  def index
    @users = User.all
  end

  #muestro solo los clientes
  def index_client
    authorize! :read, :index_client
    @users = User.where(roll: "Cliente")
  end

  # GET /users/1
  def show
    authorize! :read, :User
  end

  # GET /users/new
  def new
    authorize! :create, :User
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize! :edit, :User
  end

  # POST /users
  def create
    @user = User.new(user_params)
    #asignar el id del banco al usuario
    #obtener el id del banco por parametro
    bank_id = params[:user][:bank_id]
    @user.bank_id = bank_id
    #agregar el rol al usuario
    @user.add_role(user_params[:roll])
    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    authorize! :delete, :User
    @user.destroy
    redirect_to users_url, notice: "User was successfully destroyed."
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password, :roll)
    end
end
