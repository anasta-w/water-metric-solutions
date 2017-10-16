# Aws.config.update({
#   region:      "us-west-2",
#   credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])
# })

# sqs_client = Aws::SQS::Client.new(
# access_key_id: ENV["AWS_ACCESS_KEY_ID"],
# secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
# region: 'us-east-1'
# )
# $iot = Aws::IoT::Client.new(
# access_key_id: ENV["AWS_ACCESS_KEY_ID"],
# secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
# )

# $iot_data_plane = Aws::IoTDataPlane::Client.new(
#   access_key_id: ENV["AWS_ACCESS_KEY_ID"],
#   secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
#   endpoint: "https://" + $iot.describe_endpoint().endpoint_address
# )

# $dynamodb = Aws::DynamoDB::Client.new(
#   access_key_id: ENV["AWS_ACCESS_KEY_ID"],
#   secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
# )

# $lambda = Aws::Lambda::Client.new(
#   access_key_id: ENV["AWS_ACCESS_KEY_ID"],
#   secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
# )
