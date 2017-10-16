class FarmBlocksController < ApplicationController

  require 'base64'
  require "losant_rest"

  def index
    @user = User.find_by(id: params[:user_id])

    @farm_blocks = FarmBlock.where(user_id: @user.id)

    gon.farms = []
    @farm_blocks.all.each do |farm|
      farmBlock = {farm: farm}
      if farm.location
        farmBlock[:location] = {longitude: farm.location.longitude, latitude: farm.location.latitude}
      end
      gon.farms << farmBlock
    end
  end

  def new
    @user = User.find_by(id: params[:user_id])
    @farm_block = FarmBlock.new
    @location = Location.new
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @farm_block = FarmBlock.new(farm_block_params)
    # @location = Location.new(
    #  address: params[:address],
    #  longitude: Geocoder.search(params[:location])[0].geometry["location"]["lng"],
    #  latitude: Geocoder.search(params[:location])[0].geometry["location"]["lat"])

    @farm_block.user_id = @user.id

    if @farm_block.save
      #
      # @location.locationable_id = @farm_block.id
      # @location.locationable_type = @farm_block.class.to_s
      # @location.longitude = Geocoder.search(params[:location])[0].geometry["location"]["lng"]
      # @location.latitude = Geocoder.search(params[:location])[0].geometry["location"]["lat"]

      # if  @location.save
      redirect_to farm_block_path(@farm_block)
      # end
    else
      @errors = @farm_block.errors.messages
    end
  end

  def edit
    @farm_block = FarmBlock.find_by(id: params[:id])
  end

  def show

    @farm_block = FarmBlock.find_by(id: params[:id])

    if @farm_block.has_water_tanks?
      @water_tanks = @farm_block.water_tanks
    end

    if @farm_block.has_inflow_meters?
      @inflow_meters = @farm_block.inflow_meters
    end

    # gon.farm = {farmBlock: @farm_block}
    # if @farm_block.location
    #   gon.farm[:location] = {longitude: @farm_block.location.longitude, latitude: @farm_block.location.latitude}
    # end

    if @farm_block.water_tanks
      gon.water_tanks = []
      @farm_block.water_tanks.each do |wt|
        output = {}
        output[:name] = wt.name
        output[:capacity] = wt.capacity
        output[:height] = wt.height

        if wt.location
          output[:longitude] = wt.location.longitude
          output[:latitude] = wt.location.latitude
        end

        if wt.alerts
          output[:alerts] = wt.alerts
        end
        gon.water_tanks.push(output)
      end
    end

    if @farm_block.inflow_meters
      gon.inflow_meters = []
      @farm_block.inflow_meters.each do |inflmt|        
        # Get state device info = Inflow Meter        
        # begin
          # client = LosantRest::Client.new(auth_token: session[:losant_auth_token], url: "https://api.losant.com")
          # @result = client.device.get( applicationId: ENV['LOSANT_APP_ID'], deviceId: inflmt.device_EUI)

          output = {}
          output[:name] = inflmt.name
          output[:capacity] = inflmt.calibration_unit

          if inflmt.location
            output[:longitude] = inflmt.location.longitude
            output[:latitude] = inflmt.location.latitude
          end

          if inflmt.alerts
            output[:alerts] = inflmt.alerts
          end
          gon.inflow_meters.push(output)

        # rescue Exception => e
        #   @errors = e.to_s
        # end              
      end      
    end

  end

  def update
    @farm_block = FarmBlock.find_by(id: params[:id])

    if @farm_block.update_attributes(farm_block_params)
      redirect_to farm_block_path(@farm_block)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @farm_block = FarmBlock.find_by(id: params[:id])
    @farm_block.destroy
    redirect_to dashboard_path(current_user)
  end

  #retrieves data for all the devices belonging to a farm_block
  def get_iot_shadows
    fb_devices = {
      water_tanks: [],
      inflow_meters: []
    }
        
    # logger.debug "===PARAMS====#{params.inspect}"

    fb = FarmBlock.find(params[:id])
    client = LosantRest::Client.new(auth_token: ENV['LOSANT_API_TOKEN'], url: "https://api.losant.com")

    #================ Water tank ================#
    fb.water_tanks.each do |wt|
      fb_devices[:water_tanks].push({device: wt, type: "water-tank", deviceAlerts: wt.alerts})
    end
    
    fb_devices[:water_tanks].each do |device_object|
      device_EUI = device_object[:device].device_EUI
      losant_device_info = client.device.get(applicationId: ENV['LOSANT_APP_ID'], deviceId: device_EUI)
      losant_device_state = client.device.get_state(applicationId: ENV['LOSANT_APP_ID'], deviceId: device_EUI)

      if losant_device_info['lastUpdated'] != ''
        device_object[:sensor_health] = {message: "Online", online_status: true}
      else
        device_object[:sensor_health] = {message: "Offline", online_status: false}
      end              

      device_object[:latest_reading] =  { timestamp: SensorData.convert_timestamp_to_datetime(losant_device_state[0]['time']) }      
      device_object[:data] = losant_device_state[0]['data']['tank_level'].round(2)
          

    #   if SensorData.thing_exists?(device_object[:device].device_EUI)
    #     resp        = SensorData.get_shadow(device_object)
    #     parsed_data = SensorData.parse_shadow(resp)
    #     device_object[:shadow] = parsed_data
    #   end
    #   device_object[:sensor_health] = {
    #     message: "Offline",
    #     online_status: false
    #   }
    end

    # fb_devices[:water_tanks].each do |device_object|

    #   if SensorData.thing_exists?(device_object[:device].device_EUI)
    #     if SensorData.has_state?(device_object[:shadow])
    #       shadow        = device_object[:shadow]["state"]["reported"]
    #       aws_timestamp = shadow["ts"].to_s rescue device_object
    #       device_object[:latest_reading] = {timestamp: SensorData.convert_timestamp_to_datetime(aws_timestamp)}

    #       if SensorData.is_online?(aws_timestamp)
    #         device_object[:sensor_health][:message] = "Online"
    #         device_object[:sensor_health][:online_status] = true
    #       end

    #       if is_water_tank?(device_object)

            # raw_data = shadow["data"]
            # device = device_object[:device]
            # timestamp = shadow["ts"]
            # data = WaterTankData.new(device, raw_data, timestamp)
            # decimal_number = convert_base64_to_decimal(raw_data)
            # volume = data.calculate_volume(decimal_number, device_object[:device])
            # device_object[:latest_reading][:data] = volume
    #       end
    #     end
    #   end
    # end    

    #================ Inflow meters ================#
    fb.inflow_meters.each do |meter|
      fb_devices[:inflow_meters].push({device: meter, type:"inflow-meter", deviceAlerts: meter.alerts})
    end

    fb_devices[:inflow_meters].each do |device_object|
      # if SensorData.thing_exists?(device_object[:device].device_EUI)
      #   resp        = SensorData.get_shadow(device_object)
      #   parsed_data = SensorData.parse_shadow(resp)
      #   device_object[:shadow] = parsed_data
      # end

      device_EUI = device_object[:device].device_EUI
      losant_device_info = client.device.get(applicationId: ENV['LOSANT_APP_ID'], deviceId: device_EUI)
      losant_device_state = client.device.get_state(applicationId: ENV['LOSANT_APP_ID'], deviceId: device_EUI)
      if losant_device_info['lastUpdated'] != ''
        device_object[:sensor_health] = {message: "Online", online_status: true}
      else
        device_object[:sensor_health] = {message: "Offline", online_status: false}
      end              

      device_object[:latest_reading] = { timestamp: SensorData.convert_timestamp_to_datetime(losant_device_info['lastUpdated']) }
      # device_object[:data] = losant_device_state[0]['data']['totalflow']
      device_object[:data] = losant_device_state[0]['data']['avgflowrate'].round(2) != nil ? losant_device_state[0]['data']['avgflowrate'].round(2) : ''
    end  

    # fb_devices[:inflow_meters].each do |device_object|
    #   if SensorData.thing_exists?(device_object[:device].device_EUI)
    #     if SensorData.has_state?(device_object[:shadow])

    #       shadow        = device_object[:shadow]["state"]["reported"]
    #       aws_timestamp = shadow["ts"].to_s
    #       device_object[:latest_reading] = { timestamp: SensorData.convert_timestamp_to_datetime(aws_timestamp) }

    #       if SensorData.is_online?(aws_timestamp)
    #         device_object[:sensor_health][:message] = "Online"
    #         device_object[:sensor_health][:online_status] = true
    #       end

    #       flow_data = FlowMeterData.new(device_object[:device], shadow["data"], shadow["ts"])
    #       flow_data.convert_base64_to_decimal
    #       flow_data.calculate_flow_data
    #       device_object[:latest_reading][:data] = flow_data.calculated.to_i
    #     end
    #   end
    # end

    # Render view
    render :json => {devices: fb_devices}
  end

    private

    def convert_base64_to_decimal(base64)
      Base64.decode64(base64)
    end

    def farm_block_params
      params.require(:farm_block).permit(:name)
    end

    def location_params
      params.require(:location).permit(:longitude, :latitude, :address)
    end

    def is_water_tank?(device)
      return true if device[:type] == "water-tank"
    end

  end
