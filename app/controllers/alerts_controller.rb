class AlertsController < ApplicationController

  include AlertValue

  # before_filter :load_alertable

  def index
    @alerts = load_alertable.alerts
  end

  def new
    @alert = load_alertable.alerts.new
  end

  def create
    @alert = load_alertable.alerts.new(alert_params)
    # if (an attribute value of a node)
    #(condition here) of a custom value,
    # then do action

    if @alert.save
      type = alert_params[:condition]
      value = alert_params[:value]
      device_EUI = @alertable.device_EUI

      case type

        when 'greaterThan'
          attach_lambda_to_thing_rule(@alertable.device_EUI, 'greater_than')
        when 'lessThan'
          attach_lambda_to_thing_rule(@alertable.device_EUI, 'less_than')
      end

      create_alert_value(device_EUI, type, value)
      redirect_to context_path(@alert), notice: "Alert Created!"
    else
      @errors = @alert.errors.messages
      render :action => 'new'
    end

  end

  def edit
    @alert = load_alertable
  end

  def show
    @alert = load_alertable
  end

  def update
    @alert = Alert.find_by(id: params[:id])
    if @alert.update_attributes(alert_params)

      redirect_to context_path(@alert), notice: "Alert Updated!"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @alert = load_alertable
    @alert.destroy
    sensor = @alertable.alertable
    remove_lambda_from_thing_rule(sensor.device_EUI)
    redirect_to context_path(@alertable)
  end

  def user_check_alert
    device_EUI = params[:device_EUI]
    data       = params[:data]
    response = confirm_alert_seen(data, device_EUI)
    render :json => response
  end

  def get_all_alerts

    # if a user is NOT logged in
    # return without executing the rest of the method
    return nil unless current_user

    # create a container for the alerts
    # of all sensors / device EUIs
    alerts = []

    # iterate through all the inflow_meters that belong to the logged in user
    current_user.inflow_meters.each do |meter|
      # create a hash (JS Object) to store table name of the alerts
      # that belong to a sensor
      sensor = {table_name: meter.device_EUI}

      # retrieve all alerts for a single sensor.
      # store list of alerts from the API call to AWS in a compartment (key/value pair)
      # of the previously created sensor hash
      sensor[:alerts] = AWSAlert.get_sensor_alerts(meter)

      # Store this hash in all sensor alerts container
      alerts.push(sensor)
    end

    # iterate through all the water tanks that belong to the logged in user
    # essentially the same code as above
    current_user.water_tanks.each do |meter|
      sensor = {table_name: meter.device_EUI}
      sensor[:alerts] = AWSAlert.get_sensor_alerts(meter)

      # Store this hash in all sensor alerts container
      alerts.push(sensor)
    end

    # remove nils from array
    alerts = alerts.select do |a|
      !a[:alerts].nil?
    end

    # access container of alerts for each sensor
    alerts = alerts.each do |a|
      a[:alerts] = a[:alerts].items
    end

    # send back, to the user, the container of alerts in JSON format
    render :json => alerts
  end

  private

  def alert_params
    params.require(:alert).permit(:condition, :value, :action, :node_attribute)
  end

  def load_alertable
    resource, id = request.path.split('/')[1,2]
    unless params["action"] == "user_check_alert"
      @alertable = resource.singularize.classify.constantize.find(id)
    end
  end

  def context_path(context)
    if context.alertable_type == "WaterTank"
      water_tank_path(context.alertable_id)
    elsif context.alertable_type == "OutFlow"
      meter_path(context.alertable_id)
    elsif context.alertable_type == "InflowMeter"
      inflow_meter_path(context.alertable_id)
    elsif context.alertable_type == "Meter"
      meter_path(context.alertable_id)
    else #Incase of error
      dashboard_path
    end
  end
end
