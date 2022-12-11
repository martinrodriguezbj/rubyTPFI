class TurnsController < ApplicationController
  load_and_authorize_resource
  before_action :set_turn, only: %i[ show edit update destroy attend]
  skip_authorize_resource
 
  # GET /turns
  def index
    authorize! :read, :index
    @motivo_recibido = params[:motivo]
    #consultar si el @motivo recibido es igual a el bank del usuario
    @bank = Bank.find(@motivo_recibido)
    if @motivo_recibido.to_i == Current.user.bank_id.to_i
      @turns = @bank.turns
    else
      redirect_to @bank
    end
  end

  # GET /turns/1
  def show
    authorize! :read, :show
    #consultar si el turno le pertenece al cliente o es del banco del personal bancario
    if @turn.user_id != Current.user.id && @turn.bank_id != Current.user.bank_id
      #levantar excepcion RoutingError
      raise ActionController::RoutingError.new('Not Found')
    end
    #obtener banco
    @bank = Bank.find(@turn.bank_id)
    #obtener personal que atendio el turno
  end

  # GET /turns/new
  def new
    authorize! :create, :Turn
    @turn = Turn.new
    #obtener primer banco
    #@bank = Bank.first
    @motivo_recibido = params[:motivo]
    @bank = Bank.find(@motivo_recibido)
  end

  # GET /turns/1/edit
  def edit
    authorize! :edit, :edit
    #consultar si el turno le pertenece al cliente o es del banco del personal bancario
    if @turn.user_id != Current.user.id
      #levantar excepcion RoutingError
      raise ActionController::RoutingError.new('Not Found')
    end
    #solo se puede editar el turno si el estado es "Pendiente"
    if @turn.state != "pending"
      redirect_to @turn, alert: "Turn was not edited because it was already attended"
    end
  end

  #GET /turns/1/attend
  def attend
    authorize! :update, :attend
    @turn =  Turn.find(params[:id])
    #seguir solo si el turno no es "attended"
    if @turn.state == "attended"
      redirect_to @turn, alert: "Turn was not attended because it was already attended"
    end
  end
  
  # PATCH/PUT /turns/1
  def attended
    #recibir el result de turno por parametro
    @result = params[:turn][:result]
    if @result == ""
      render :attend, status: :unprocessable_entity
    else
      @turn = Turn.find(params[:id])
      @turn.state = "attended"
      @turn.result = @result
      @turn.bank_staff = Current.user.id
      @turn.save
      redirect_to @turn, notice: "Turn was successfully attended."
    end
  end

  def past_turns
    #mostrar los turnos del usuario actua si dia es menor a hoy
    @user = Current.user
    @turns = @user.turns.where("day < ?", Date.today)
    authorize! :read, :past_turns
  end

  def future_turns
    #mostrar los turnos del usuario actua si dia es mayor o igual a hoy
    @user = Current.user
    @turns = @user.turns.where("day >= ?", Date.today)
    authorize! :read, :future_turns
  end

  # POST /turns
  def create
    @turn = Turn.new(turn_params)
    @turn.user_id = Current.user.id
    @turn.state = "pending"
    @bank = Bank.find(@turn.bank_id)
    if @turn.save
      redirect_to @turn, bank: @bank, notice: "Turn was successfully created."
    else
      render :new, bank: @bank, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /turns/1
  def update
    
    if @turn.update(turn_params)
      redirect_to @turn, notice: "Turn was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /turns/1
  def destroy
    authorize! :delete, :destroy
    if @turn.state != "Pendiente"
      @turn.destroy
      redirect_to turns_url, notice: "Turn was successfully destroyed."
    else
      redirect_to turns_url, notice: "Turn was not destroyed because it is pending"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn
      @turn = Turn.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turn_params
      params.require(:turn).permit(:bank_id, :user_id, :day, :hour, :reason, :state, :result, :bank_staff)
    end
end
