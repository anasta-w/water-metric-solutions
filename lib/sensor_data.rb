
class SensorData

  def SensorData.is_online?(ts)
    # current_time = Time.now.strftime("%s").to_i # get current time in Unix format
    # seconds_difference = current_time - ts.to_i

    # if seconds_difference > 3600
    #   return false
    # else
    #   return true
    # end
  end

  def SensorData.get_shadow(device)
    # $iot_data_plane.get_thing_shadow({ # returns an object of the StringIO class
    #   thing_name: device[:device].device_EUI
    # })
  end

  def SensorData.parse_shadow(raw_data)
    # return JSON.parse(raw_data.payload.string)
  end

  def SensorData.convert_timestamp_to_datetime(ts)

    # ts_string = ts.to_s[0,10] #we don't need the last 3 digits of information  

    # datetime = DateTime.strptime(ts_string, '%s')

    # time = datetime.to_time.strftime("%H:%M:%S %P")
    # date = datetime.to_date

    # new_datetime = "#{date} #{time}"

    # datetime = DateTime.strptime(ts, '%s')

    # return datetime.to_date
        
    date = ts.slice(0, 10)
    time = ts.slice(11, 8)
    return "#{date} #{time}"
  end

  def SensorData.thing_exists?(thing_name)

      # aws_thing_test = $iot.describe_thing({
      # thing_name: thing_name
      # }) rescue false

      # return true if aws_thing_test

      # false
  end

  def self.has_state?(data_payload)

    # return true if data_payload["state"]["reported"]

    # false
  end

end
