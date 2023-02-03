class TurnsController < ApplicationController
  load_and_authorize_resource
  before_action :set_turn, only: %i[ show edit update destroy attend]
  skip_authorize_resource
 

  # GET /turns
  #consulto si el @motivo recibido es igual a el bank del usuario, 
  #si es asi, solo aquellos turnos que no esten attended
  def index
    authorize! :read, :index
    @motivo_recibido = params[:motivo]
    @bank = Bank.find(@motivo_recibido)
    if @motivo_recibido.to_i == Current.user.bank_id.to_i
      @turns = Turn.where(bank_id: @motivo_recibido, state: "pending")
    else
      redirect_to @bank
    end
  end

  # GET /turns/1
  #muestro turno, solo si le pertenece al cliente o es del banco del personal bancario
  def show
    authorize! :read, :showTurn
    if @turn.user_id != Current.user.id && @turn.bank_id != Current.user.bank_id
      raise ActionController::RoutingError.new('Not Found')
    end
    @bank = Bank.find(@turn.bank_id)
    if @turn.bank_staff
      @bank_staff = User.find(@turn.bank_staff)
    end
  end

  # GET /turns/new
  def new
    authorize! :create, :Turn
    @turn = Turn.new
    @motivo_recibido = params[:motivo]
    @bank = Bank.find(@motivo_recibido)
  end

  # GET /turns/1/edit
  #consulto si el turno le pertenece al cliente o es del banco del personal bancario.
  #si es asi, solo se puede editar el turno si el estado es "Pendiente"
  def edit
    authorize! :edit, :editTurn
    if @turn.user_id != Current.user.id
      raise ActionController::RoutingError.new('Not Found')
    end
    if @turn.state != "pending"
      redirect_to @turn, alert: "Turn was not edited because it was already attended"
    end
  end

  #GET /turns/1/attend
  def attend
    authorize! :update, :attend
    @turn =  Turn.find(params[:id])
    if @turn.state == "attended"
      redirect_to @turn, alert: "Turn was not attended because it was already attended"
    end
  end
  
  # PATCH/PUT /turns/1
  def attended
    @result = params[:turn][:result]
    if @result == ""
      redirect_to attend_turn_path(params[:id]), alert: "Result can't be blank"
    else
      @turn = Turn.find(params[:id])
      @turn.state = "attended"
      @turn.result = @result
      @turn.bank_staff = Current.user.id
      if @turn.save
        redirect_to @turn, notice: "Turn was successfully attended."
      else
        render :attend, status: :unprocessable_entity
      end
    end
  end

  def past_turns
    @user = Current.user
    @turns = @user.turns.where("day < ?", Date.today)
    authorize! :read, :past_turns
  end

  def future_turns
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
    authorize! :delete, :destroyTurn
    if @turn.state != "attended"
      @turn.destroy
      redirect_to banks_path, notice: "Turn was successfully destroyed."
    else
      redirect_to banks_path, alert: "Turn was not destroyed because it was already attended"      
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
