class LocalitiesController < ApplicationController
  load_and_authorize_resource
  before_action :set_locality, only: %i[ show edit update destroy ]

  # GET /localities
  def index
    @localities = Locality.all
  end

  # GET /localities/1
  def show
  end

  # GET /localities/new
  def new
    @locality = Locality.new
  end

  # GET /localities/1/edit
  def edit
  end

  # POST /localities
  def create
    @locality = Locality.new(locality_params)

    if @locality.save
      redirect_to @locality, notice: "Locality was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /localities/1
  def update
    if @locality.update(locality_params)
      redirect_to @locality, notice: "Locality was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /localities/1
  def destroy
    #consultar si algun banco tiene esta localidad
    if Bank.where(locality_id: @locality.id).first
      redirect_to localities_url, alert: "Cannot delete a locality that has associated banks."
    else
      @locality.destroy
      redirect_to localities_url, notice: "Locality was successfully destroyed."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_locality
      @locality = Locality.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def locality_params
      params.require(:locality).permit(:locality, :province)
    end
end
