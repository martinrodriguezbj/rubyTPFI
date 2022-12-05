class BanksController < ApplicationController
  load_and_authorize_resource
  before_action :set_bank, only: %i[ show edit update destroy ]
  skip_before_action :protect_pages, only: [:index, :show]


  # GET /banks
  def index
    @banks = Bank.all
  end

  # GET /banks/1
  def show
  end

  # GET /banks/new
  def new
    @bank = Bank.new
  end

  # GET /banks/1/edit
  def edit
  end

  # POST /banks
  def create
    @bank = Bank.new(bank_params)
    #instanciar horarios de atencion de 9 a 12 de luenes a viernes y agregarlos al banco
    @schedule1 = Schedule.new(day: "Monday", startAttention: nil, endAttention: nil)
    @schedule2 = Schedule.new(day: "Tuesday", startAttention: nil, endAttention: nil)
    @schedule3 = Schedule.new(day: "Wednesday", startAttention: nil, endAttention: nil)
    @schedule4 = Schedule.new(day: "Thursday", startAttention: nil, endAttention: nil)
    @schedule5 = Schedule.new(day: "Friday", startAttention: nil, endAttention: nil)
    #guardaer todos los schedules en el banco
    @bank.schedules << @schedule1
    @bank.schedules << @schedule2
    @bank.schedules << @schedule3
    @bank.schedules << @schedule4
    @bank.schedules << @schedule5
    if @bank.save
      redirect_to @bank, notice: "Bank was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /banks/1
  def update
    if @bank.update(bank_params)
      redirect_to @bank, notice: "Bank was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /banks/1
  def destroy
    @bank.destroy
    redirect_to banks_url, notice: "Bank was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_params
      params.require(:bank).permit(:name, :address, :phone)
    end
end
