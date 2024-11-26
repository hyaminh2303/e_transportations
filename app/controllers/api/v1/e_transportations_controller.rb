class Api::V1::ETransportationsController < Api::V1::BaseController
  before_action :set_resource_class
  before_action :set_e_transportation, only: %i[ show update destroy ]

  # GET /api/v1/e_e_transportations
  def index
    @pagy, @e_transportations = pagy(@resource_class.all)
  end

  def outside_power_report
    render json: EScooter.outside_power_report
  end

  # GET /api/v1/e_e_transportations/1
  def show
  end

  # POST /api/v1/e_e_transportations
  def create
    @e_transportation = @resource_class.new(e_transportation_params)

    if @e_transportation.save
      render :show, status: :created
    else
      render_error(@e_transportation, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /api/v1/e_e_transportations/1
  def update
    if @e_transportation.update(e_transportation_params)
      render :show, status: :ok
    else
      render_error(@e_transportation, status: :unprocessable_entity)
    end
  end

  # DELETE /api/v1/e_e_transportations/1
  def destroy
    @e_transportation.destroy!
  end

  private
    def set_resource_class
      @resource_class = case params[:type]
      when "EBike"
        EBike
      when "EScooter"
        EScooter
      else
        ETransportation
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_e_transportation
      @e_transportation = find_resource(@resource_class, params[:id])
    end

    # Only allow a list of trusted parameters through.
    def e_transportation_params
      params.require(:e_transportation).permit(:sensor_type, :owner_id, :in_zone, :lost_sensor)
    end
end
