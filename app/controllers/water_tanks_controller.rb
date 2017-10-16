class WaterTanksController < ApplicationController
  require "losant_rest"

  def new
    @farm_block = FarmBlock.find_by(id: params[:farm_block_id])
    @water_tank = WaterTank.new
  end

  def create
    @error = ''     
    if water_tank_params[:height].present? && water_tank_params[:capacity].present? && water_tank_params[:name].present? && water_tank_params[:device_EUI].present?
      @farm_block = FarmBlock.find_by(id: params[:farm_block_id])
      @water_tank = WaterTank.new(water_tank_params)
      @water_tank.farm_block_id = @farm_block.id
      if @water_tank.save
        # begin
        #   Sensor.create_thing(@water_tank)
        #   Sensor.create_thing_database(@water_tank)
        #   Sensor.create_thing_rule(@water_tank)
        # rescue Aws::DynamoDB::Errors::ResourceInUseException => error
        #   @errors = error
        #   return render :action => 'new'
        # rescue Aws::DynamoDB::Errors::ValidationException => error
        #   @errors = error
        #   return render :action => 'new'
        # rescue Aws::IoT::Errors::InvalidRequestException => error
        #   @errors = error
        #   return render :action => 'new'
        # end

        #========================================================# 
        # Save as new Dashboard in Losant
        #========================================================# 
         begin
           my_device = {
             "name": water_tank_params['device_EUI'],
             "description": "New device" + water_tank_params['name'],
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

           urlApi =  "https://59d54e901dd3d200070cd75b.onlosant.com/devices"

        #   urlApi =  "https://590bc7a2c8f13000014788c5.onlosant.com/devices"
           response = HTTP.post(urlApi, :json => my_device)


          # client = LosantRest::Client.new(auth_token: session[:losant_auth_token], url: url)
          # result = client.devices.post(applicationId: ENV['LOSANT_APP_ID'], device: my_device)
        # rescue => e
        #   @error = e.to_s              
        #   flash[:failure] = @error
        #   return render :action => 'new'
         end
        #========================================================# 
        # End save as new Dashboard in Losant
        #========================================================# 

        return redirect_to water_tank_path(@water_tank)      
      else
        @errors = @water_tank.errors.messages
        flash[:failure] = @errors
        return render :action => 'new'
      end
    else      
      @errors = "Data not epmty"
      flash[:failure] = @errors
      return render :action => 'new'
    end
  end

  def edit
    @water_tank = WaterTank.find_by(id: params[:id])
  end

  def show
    @water_tank = WaterTank.find_by(id: params[:id])
    @alerts = @water_tank.alerts

    gon.water_tank = {}

    # unless Sensor.table_exists?(@water_tank.device_EUI)
    #   begin
    #     Sensor.create_thing_database(@water_tank)
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
    #   resp = Sensor.scan_dynamodb(@water_tank)
    # rescue Aws::DynamoDB::Errors::ResourceNotFoundException => error
    #   puts error
    #   message = "Sensor Database Initialising!"
    #   @error = {
    #     message: message,
    #     error:   error
    #   }
      gon.water_tank[:data] = []
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
    #     flow_data = WaterTankData.new(@water_tank, entry["payload"]["data"], entry["timestamp"])
    #     flow_data.convert_base64_to_decimal
    #     flow_data.calculate_volume(flow_data.calculated.to_i, @water_tank)
    #     flow_data
    #   end

      gon.water_tank[:data] = 86.30
    # end

    gon.water_tank[:sensor] = @water_tank

  end

  def update
    @water_tank = WaterTank.find_by(id: params[:id])

    if @water_tank.update_attributes(water_tank_params)
      redirect_to water_tank_path(@water_tank)
    else
      render :action => 'edit'
    end
  end

  def destroy
    water_tank = WaterTank.find_by(id: params[:id])
    # $iot.delete_thing({
    #   thing_name: water_tank.device_EUI
    #   })
    water_tank.destroy
    redirect_to dashboard_path(current_user)
  end

  def get_tank_data
    outputs = WaterTank.find(params[:water_tank_id]).sensor_outputs
    dates = []
    
    
    #if the user wants data over several days
    last_sensor_date = 0
    outputs.each do |output|
      utc_timestamp = convert_timestamp_to_datetime(output.sent_at)
      dates.push(utc_timestamp)
    end
    
    render :json => {outputs: outputs,
                      dates: dates}
  end

  private

  def water_tank_params
    params.require(:water_tank).permit(:height, :capacity, :name, :device_EUI, :farm_block_id)
  end

end
