class Api::V1::ETransportationsController < ApplicationController
  before_action :set_e_transportation, only: %i[ show update destroy ]

  # GET /api/v1/e_e_transportations
  def index
    @e_transportations = ETransportation.all
  end

  # GET /api/v1/e_e_transportations/1
  def show
  end

  # POST /api/v1/e_e_transportations
  def create
    @e_transportation = ETransportation.new(e_transportation_params)

    if @e_transportation.save
      render :show, status: :created
    else
      render json: @e_transportation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/e_e_transportations/1
  def update
    if @e_transportation.update(e_transportation_params)
      render :show, status: :ok
    else
      render json: @e_transportation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/e_e_transportations/1
  def destroy
    @e_transportation.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_e_transportation
      @e_transportation = ETransportation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def e_transportation_params
      params.require(:e_transportation).permit(:e_e_transportation_type, :sensor_type, :owner_id, :in_zone, :lost_sensor)
    end
end
