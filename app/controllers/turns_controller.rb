class TurnsController < ApplicationController
  before_action :set_turn, only: %i[ show edit update destroy attend]

  # GET /turns
  def index
    @turns = Turn.all
  end

  # GET /turns/1
  def show
  end

  # GET /turns/new
  def new
    @turn = Turn.new
    #obtener primer banco
    #@bank = Bank.first
    @motivo_recibido = params[:motivo]
    @bank = Bank.find(@motivo_recibido)
  end

  # GET /turns/1/edit
  def edit
  end

  #GET /turns/1/attend
  def attend
    @turn =  Turn.find(params[:id])
  end
  
  # PATCH/PUT /turns/1
  def attended
    #mensaje por consola
    puts "entro a attended"
    @turn = Turn.find(params[:id])
    @turn.state = "attended"
    @turn.bank_staff = Current.user.id
    @turn.save
    redirect_to @turn
  end

  # POST /turns
  def create
    @turn = Turn.new(turn_params)
    @turn.user_id = Current.user.id
    #recibir id de banco pasado por hidden_field
    @idbank = params[:turn][:bank_id]
    @turn.bank_id = @idbank
    #poner state del turno en "sin atender"
    if @turn.save
      redirect_to @turn, notice: "Turn was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /turns/1
  def update
    if @turn.update(turn_params)
      @turn.state = "not attended"
      @turn.save
      redirect_to @turn, notice: "Turn was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /turns/1
  def destroy
    @turn.destroy
    redirect_to turns_url, notice: "Turn was successfully destroyed."
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
