class AppartmentsController < ApplicationController
  before_action :set_appartment, only: [:edit, :update, :destroy, :update_earning]
  before_action :authenticate_author!

  # GET /appartments
  # GET /appartments.json
  def index
    @appartments = current_author.appartments.order("created_at desc").paginate(:page => params[:page], :per_page => 10)
  end

  def update_earning
    AirbnbWorker.perform_async(@appartment.id)
    redirect_to root_path, notice: 'Wait few seconds for update'
  end

  # GET /appartments/new
  def new
    @appartment = Appartment.new
  end

  # GET /appartments/1/edit
  def edit
  end

  # POST /appartments
  # POST /appartments.json
  def create
    @appartment = Appartment.new(appartment_params)
    @appartment.author_id = current_author.id
    respond_to do |format|
      if @appartment.save
        AirbnbWorker.perform_async(@appartment.id)
        format.html { redirect_to appartments_url, notice: 'Appartment was successfully created.' }
        format.json { render :show, status: :created, location: @appartment }
      else
        format.html { render :new }
        format.json { render json: @appartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appartments/1
  # PATCH/PUT /appartments/1.json
  def update
    respond_to do |format|
      if @appartment.update(appartment_params)
        AirbnbWorker.perform_async(@appartment.id)
        format.html { redirect_to appartments_url, notice: 'Appartment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appartment }
      else
        format.html { render :edit }
        format.json { render json: @appartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appartments/1
  # DELETE /appartments/1.json
  def destroy
    @appartment.destroy
    respond_to do |format|
      format.html { redirect_to appartments_url, notice: 'Appartment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appartment
      @appartment = Appartment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appartment_params
      params.require(:appartment).permit(:address, :rent)
    end
end
