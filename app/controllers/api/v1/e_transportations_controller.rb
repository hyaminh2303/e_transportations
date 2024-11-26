class Api::V1::ETransportationsController < ApplicationController
  before_action :set_transportation, only: %i[ show update destroy ]

  # GET /api/v1/e_transportations
  def index
    @transportations = ETransportation.all
  end

  # GET /api/v1/e_transportations/1
  def show
  end

  # POST /api/v1/e_transportations
  def create
    @transportation = ETransportation.new(transportation_params)

    if @transportation.save
      render :show, status: :created, location: @transportation
    else
      render json: @transportation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/e_transportations/1
  def update
    if @transportation.update(transportation_params)
      render :show, status: :ok, location: @transportation
    else
      render json: @transportation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/e_transportations/1
  def destroy
    @transportation.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transportation
      @transportation = ETransportation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transportation_params
      params.require(:transportation).permit(:e_transportation_type, :sensor_type, :owner_id, :in_zone, :lost_sensor)
    end
end
