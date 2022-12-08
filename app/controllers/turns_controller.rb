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
    #obtener banco
    @bank = Bank.find(@turn.bank_id)
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
  end

  #GET /turns/1/attend
  def attend
    authorize! :update, :attend
    @turn =  Turn.find(params[:id])
  end
  
  # PATCH/PUT /turns/1
  def attended
    @turn = Turn.find(params[:id])
    @turn.state = "attended"
    @turn.bank_staff = Current.user.id
    @turn.save
    redirect_to @turn
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
    #obtener el parametro del dia
    @day = params[:turn][:day]
    #obtener que nombre de dia es @day
    @day_name = Date.parse(@day).strftime("%A")
    #imprimir en consola el nombre del dia de hoy es @day_name
    puts "el nombre del dia de hoy es #{@day_name}"
    @turn = Turn.new(turn_params)
    @turn.user_id = Current.user.id
    #recibir id de banco pasado por hidden_field
    @idbank = params[:turn][:bank_id]
    #obtengo el banco con el id recibido
    @bank = Bank.find(@idbank)
    #filtrar el hoario cuyo dia sea igual a @day_name
    @schedule = @bank.schedules.where(day: @day_name)
    #obtener el horario del turno recibido
    @hour = params[:turn][:hour]
    #obtener los dos primeros caracteres de @hour
    @hour = @hour[0..1].to_i
    #verificar si el horario del turno recibido esta dentro del horario de atencion de @schedule
    #obtener startAttention y endAttention de @schedule
    @startAttention = @schedule.where(day: @day_name).first.startAttention.to_i
    @endAttention = @schedule.where(day: @day_name).first.endAttention.to_i
    puts "COMIENZO DE ATENCION DEL MARTES ES #{@startAttention}"
    puts "FIN DE ATENCION DEL MARTES ES #{@endAttention}"
    puts "HORA DEL TURNO ES #{@hour}"
    estaEntre = (@startAttention..@endAttention).include?(@hour)
    #chequear si el banco ya tiene un turno para ese dia y hora
    ocupado = @bank.turns.where(day: @day, hour: @hour).exists?
    puts "VALOR DE ESTAENTRE ES #{estaEntre}"
    @turn.bank_id = @idbank
    #poner state del turno en "sin atender"
    if !ocupado and estaEntre and @turn.save
      redirect_to @turn, notice: "Turn was successfully created."
    else
      redirect_to new_turn_path(motivo: @idbank), notice: "Turn was not created because the hour is not between the attention hours of the bank"
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
