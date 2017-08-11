class AppartmentsController < ApplicationController
  before_action :set_appartment, only: [:edit, :update, :destroy, :update_earning]
  before_action :authenticate_author!

  def index
    @appartments = current_author.appartments.order("created_at desc").paginate(:page => params[:page], :per_page => 10)
  end

  def update_earning
    AirbnbWorker.perform_async(@appartment.id)
    redirect_to root_path, notice: 'Wait at least 10 seconds for getting earning from AirBnB and refresh a page'
  end

  def new
    @appartment = Appartment.new
  end

  def edit
  end

  def create
    @appartment = Appartment.new(appartment_params)
    @appartment.author_id = current_author.id
    respond_to do |format|
      if @appartment.save
        AirbnbWorker.perform_async(@appartment.id)
        format.html { redirect_to appartments_url, notice: 'Appartment created, wait at least 10 seconds for getting earning from AirBnB' }
        format.json { render :show, status: :created, location: @appartment }
      else
        format.html { render :new }
        format.json { render json: @appartment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @appartment.update(appartment_params)
        AirbnbWorker.perform_async(@appartment.id)
        format.html { redirect_to appartments_url, notice: 'Appartment updated, wait at least 10 seconds for getting earning from AirBnB' }
        format.json { render :show, status: :ok, location: @appartment }
      else
        format.html { render :edit }
        format.json { render json: @appartment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appartment.destroy
    respond_to do |format|
      format.html { redirect_to appartments_url, notice: 'Appartment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_appartment
      @appartment = Appartment.find(params[:id])
    end

    def appartment_params
      params.require(:appartment).permit(:address, :rent)
    end
end
