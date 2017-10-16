class WaterTankData < SensorData

  require 'base64'

  attr_reader :raw, :calculated, :volume

  def initialize(water_tank, raw_data, timestamp)
    raise ArgumentError.new("You must include a Water Tank Object") if water_tank == nil
    @water_tank = water_tank
    @raw = raw_data
    @timestamp = timestamp.to_i
    @calculated, @volume = nil
  end

  def convert_base64_to_decimal
    # returns a string
    @calculated = Base64.decode64(@raw)
  end

  def calculate_volume(data, water_tank)
    radius = WaterTankData.calculate_radius(water_tank.capacity, water_tank.height)

    water_tank_cm = water_tank.height * 100

    # 'data' variable is a string
    # must be converted to an integer to perform calculation
    data_height = water_tank_cm - data.to_i

    # convert both values to floats
    # we can be sure that whatever is returned will not be a rational number
    data_height_ratio = data_height.to_f / water_tank_cm.to_f

    @volume = data_height_ratio * water_tank.capacity

    # final_volume_metres_cubed = Math::PI * data_height * radius
    # @volume = (final_volume_metres_cubed * 1000).round #convert volume in metres cubed into litres

  end

  def self.calculate_radius(capacity, height)
    result1 = Math::PI * height
    volume_meters_cubed = capacity / 1000
    result2 = volume_meters_cubed / result1
    result3 = Math.sqrt(result2)
    round_radius = result3.round(1)
    return round_radius
  end

end
