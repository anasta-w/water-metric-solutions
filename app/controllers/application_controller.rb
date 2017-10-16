class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  # require 'Alert'

  helper_method :current_user
  helper_method :logged_in?
  helper_method :get_outta_here
  helper_method :get_all_alerts
  helper_method :get_alert_parent_name
  helper_method :get_device_count
  helper_method :alert_seen

  def current_user
    @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # def current_user
  #   @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  # end

  def logged_in?
    current_user && session[:user_id]
  end

  def get_outta_here
    redirect_to landing_path
  end

  # def logged_in?
  #   return true if current_user && cookies[:auth_token]
  # end

  def convert_hex_to_dec(hex)
    return hex.to_i(16)
  end


  def get_alert_parent_name(a)
    alerts = get_all_alerts
    device_EUI = alerts[a][:table_name]
    name = InflowMeter.find_by(device_EUI:device_EUI).name
  end

  def get_device_count
    # results = []
    # devices = Alert.get_all_alerts.length - 1
    # a = 0
    # b = 0
    # while a <= devices
    #   alert_count = get_all_alerts[a][:alerts].length - 1
    #   while b <= alert_count
    #     name = get_alert_parent_name(a)
    #     data = get_all_alerts[a][:alerts][b]["data"]
    #     seen = get_all_alerts[a][:alerts][b]["seen"]
    #     type = get_all_alerts[a][:alerts][b]["type"]
    #     if seen == false
    #       results << {name: name, data: data, type: type}
    #     end
    #     b = b + 1
    #   end
    #   a = a + 1
    # end
    # results
    []
  end
  def alert_seen(a, i)
    x = a
    y = i
    get_all_alerts[x][:alerts][y]["seen"] = true
  end
end
