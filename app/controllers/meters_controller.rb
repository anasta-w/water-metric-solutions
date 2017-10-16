class MetersController < ApplicationController
  require "losant_rest"

  def index

  end

  def new
    @farm_block = FarmBlock.find_by(id: params[:farm_block_id])
    @meter = Meter.new
  end

  def create
    @farm_block = FarmBlock.find_by(id: params[:farm_block_id])
    @meter = Meter.new(meter_params)
    @meter.farm_block_id = @farm_block.id
    if @meter.save
      redirect_to meter_path(@meter)
    else
      @errors = @meter.errors.messages
      render :action => 'new'
    end

  end

  def edit
    @meter = Meter.find_by(id: params[:id])
  end

  def show
    @meter = Meter.find_by(id: params[:id])
    @alerts = @meter.alerts
  end

  def update
    @meter = Meter.find_by(id: params[:id])

    if @meter.update_attributes(meter_params)
      redirect_to dashboard_path(session[:user_id])
    else
      render :action => 'edit'
    end
  end

  def destroy
    @meter = Meter.find_by(id: params[:id])
    @meter.destroy
    redirect_to dashboard_path(current_user)
  end

  private

  def meter_params
    params.require(:meter).permit(:name, :calibration_unit, :type)
  end
end