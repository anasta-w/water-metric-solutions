module AWSAlert

  def self.get_sensor_alerts(sensor)

    # table_name = sensor.device_EUI + "_alerts"

    # params = {
    #   table_name: table_name
    # }

    # begin
    #   alerts = $dynamodb.scan(params)
    # rescue Aws::DynamoDB::Errors::ResourceNotFoundException => e
    #   nil #handle
    # rescue Aws::DynamoDB::Errors::ValidationException => e
    #   nil #handle
    # end

  end

end
