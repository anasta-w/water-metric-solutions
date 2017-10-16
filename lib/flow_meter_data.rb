class FlowMeterData < SensorData

  require 'base64'

  attr_reader :raw, :calculated, :normalised, :parsed

  def initialize(flow_meter, raw_data, timestamp)
    raise ArgumentError.new("You must include a Flow Meter Object") if flow_meter == nil
    @flow_meter = flow_meter
    @raw = raw_data
    @timestamp = timestamp.to_i
    @normalised, @calculated, @parsed = nil
  end

  def convert_base64_to_decimal
    @parsed = Base64.decode64(@raw) rescue "0"
  end

  def normalise_flow_data

    # chop up the string every second element
    # iterate through every character pair
    # make each char pair a hex string
    # convert to ASCII value
    @normalised = raw.scan(/../).map do |element|
      hex_string = ("0x" + element).hex
      convert_hexidecimal_value_to_ascii(hex_string)
    end
  end

  def parse_flow_data
    raise "Data cannot be calculated yet!" if normalised == nil

    result1 = strip_boundary_symbols(@normalised)
    result2 = compartmentalise_hexadecimal_pairs(result1)
    @parsed = combine_hexadecimal_pairs(result2)
  end

  def calculate_flow_data
    raise "Data cannot be calculated yet!" if parsed == nil
    raise "calibration_unit is incorrect" if @flow_meter.calibration_unit.class != Fixnum
    # readings = parsed.map do |val|
    #   convert_hexidecimal_value_to_decimal(val)
    # end

    # @calculated = calculate_average(readings)

    @calculated = parsed.to_i * @flow_meter.calibration_unit
  end

  private

  def calculate_average(arr_of_readings)
    total = 0.0
    arr_of_readings.each do |num|
      total += num if num.class == Fixnum
    end

    return total / arr_of_readings.length
  end

  def convert_hexidecimal_value_to_decimal(hex)
    hex.to_i(16)
  end

  def convert_hexidecimal_value_to_ascii(hex)
    hex.chr
  end

  def combine_hexadecimal_pairs(hex_values)
    hex_values.map do |hex|
      clean_dollar_signs(hex).join
    end
  end

  def clean_dollar_signs(chars)

    # if an element inside the sub array
    # is a dollar sign
    # => convert to empty string
    chars.map { |e| e == "$" ? e = "" : e }

  end

  def compartmentalise_hexadecimal_pairs(values)
    container = []
    result = []
    values.each_with_index do |el, i|
      container << el
      if i % 2 != 0
        result << container
        container = []
      end
    end

    return result
  end

  def strip_boundary_symbols(list_of_hex)
    list_of_hex.keep_if { |c| c != "%" }
  end


end
