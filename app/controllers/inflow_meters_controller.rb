class InflowMetersController < ApplicationController

  # require "Sensor"
  require "losant_rest"

  def new
    @farm_block = FarmBlock.find_by(id: params[:farm_block_id])
    @inflow_meter = InflowMeter.new
  end

  def create
    @errors = ''
    @inflow_meter = []
    begin
      if inflow_meter_params[:name].present? && inflow_meter_params[:calibration_unit].present? && inflow_meter_params[:device_EUI].present? && inflow_meter_params[:daily_consent].present?
        @farm_block = FarmBlock.find_by(id: params[:farm_block_id])
        @inflow_meter = InflowMeter.new(inflow_meter_params)
        @inflow_meter.farm_block_id = @farm_block.id


        begin
          my_device = {
              "name": inflow_meter_params[:name],
              "description": "New device" ,
              "tags": [
                  {
                      "key": "sigfox_id",
                      "value": "1C8E99"
                  },
                  {
                      "key": "sensor_input",
                      "value": "1"
                  }
              ],
              "attributes": [
                  {
                      "name": "location",
                      "dataType": "gps"
                  },
                  {
                      "name": "snr",
                      "dataType": "number"
                  },
                  {
                      "name": "station",
                      "dataType": "string"
                  },
                  {
                      "name": "data",
                      "dataType": "string"
                  },
                  {
                      "name": "avgSnr",
                      "dataType": "number"
                  },
                  {
                      "name": "rssi",
                      "dataType": "number"
                  },
                  {
                      "name": "seqNumber",
                      "dataType": "number"
                  },
                  {
                      "name": "pulse",
                      "dataType": "number"
                  },
                  {
                      "name": "battery",
                      "dataType": "number"
                  },
                  {
                      "name": "totalflow",
                      "dataType": "number"
                  }
              ],
              "deviceClass": "standalone"
          }
          #   url= "https://590bc7a2c8f13000014788c5.onlosant.com/devices"
          # r=Net::HTTP.post_form(url, my_device)
          urlApi =  "https://59b9ac8ebc9c9b0007659ade.onlosant.com/devices"
          #   urlApi =  "https://590bc7a2c8f13000014788c5.onlosant.com/devices"
          response = HTTP.post(urlApi, :json => my_device)
          # client = LosantRest::Client.new(auth_token: session[:losant_auth_token], url: url)
          # result = client.devices.post(applicationId: ENV['LOSANT_APP_ID'], device: my_device)
          # rescue => e
          #   @error = e.to_s
          #   flash[:failure] = @error
          #   return render :action => 'new'
        end



        if @inflow_meter.save
          #   begin
          #     Sensor.create_thing(@inflow_meter)
          #     Sensor.create_thing_database(@inflow_meter)
          #     Sensor.create_thing_rule(@inflow_meter)
          #   rescue Aws::DynamoDB::Errors::ResourceInUseException => error
          #     @errors = error
          #     return render :action => 'new'
          #   rescue Aws::DynamoDB::Errors::ValidationException => error
          #     @errors = error
          #     return render :action => 'new'
          #   rescue Aws::IoT::Errors::InvalidRequestException => error
          #     @errors = error
          #     return render :action => 'new'
          #   end
          #   return redirect_to inflow_meter_path(@inflow_meter)
          # else
          #   @errors = @inflow_meter.errors.messages

          return redirect_to farm_block_path(@farm_block)
        end
      else
        @errors = "Data not empty"
        flash[:failure] = @errors
        render :action => 'new'
      end
    rescue => e
      @errors = "Error!" + e.to_s
      flash[:failure] = @errors
      render :action => 'new'
    end
  end

  def edit
    @inflow_meter = InflowMeter.find_by(id: params[:id])
  end

  def show
    @inflow_meter = InflowMeter.find_by(id: params[:id])
    @alerts = @inflow_meter.alerts
    gon.inflow_meter = {}

    #================================================#
    # Get state device info = Meter
    #================================================#
    begin
      client = LosantRest::Client.new(auth_token: session[:losant_auth_token], url: "https://api.losant.com")
      @result = client.device.get_composite_state( applicationId: ENV['LOSANT_APP_ID'], deviceId: '59b9ac8ebc9c9b0007659ade')
    rescue Exception => e
      @errors = e.to_s
    end
    #================================================#
    # End get state device info = Meter
    #================================================#

    # unless Sensor.table_exists?(@inflow_meter.device_EUI)
    #   begin
    #     Sensor.create_thing_database(@inflow_meter)
    #   rescue Aws::DynamoDB::Errors::ValidationException => error
    #     puts error
    #     message = "There is a problem with your sensor's device EUI!"
    #     @error = {
    #       error: error,
    #       message: message
    #     }
    #   end
    # end

    # begin
    #   resp = Sensor.scan_dynamodb(@inflow_meter)
    # rescue Aws::DynamoDB::Errors::ResourceNotFoundException => error
    #   puts error
    #   message = "Sensor Database Initialising!"
    #   @error = {
    #     message: message,
    #     error:   error
    #   }
    #   gon.inflow_meter[:data] = []
    # rescue Aws::DynamoDB::Errors::ValidationException => error
    #   puts error
    #   message = "There is a problem with your sensor's device EUI!"
    #   @error = {
    #     error: error,
    #     message: message
    #   }
    # else
    #   all_items = resp.items

    #   calculated_data = all_items.map do |entry|
    #     flow_data = FlowMeterData.new(@inflow_meter, entry["payload"]["data"], entry["timestamp"])
    #     flow_data.convert_base64_to_decimal
    #     flow_data.calculate_flow_data
    #     flow_data
    #   end

    #   gon.inflow_meter[:data] = calculated_data
    # end

    gon.inflow_meter[:sensor] = @inflow_meter
  end

  def update
    @inflow_meter = InflowMeter.find_by(id: params[:id])

    if @inflow_meter.update_attributes(inflow_meter_params)
      redirect_to inflow_meter_path(@inflow_meter)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @inflow_meter = InflowMeter.find_by(id: params[:id])
    @inflow_meter.destroy
    redirect_to dashboard_path(current_user)
  end

  private

  def inflow_meter_params
    params.require(:inflow_meter).permit(:name, :calibration_unit, :device_EUI, :daily_consent,:type)
  end
end