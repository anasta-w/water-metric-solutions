
module Sensor

  def self.create_thing(sensor)

    # name = sensor.device_EUI.to_s

    # return if self.thing_exists?(name)

    # # $iot.create_thing({
    # #   thing_name: name
    # # })
  end

  def self.create_thing_database(sensor)

    # table_name = sensor.device_EUI

    # return if self.table_exists?(table_name)

    # hash_key_name = "timestamp"

    # params = {
    #   table_name: table_name,
    #   attribute_definitions: [
    #     {
    #       attribute_name: hash_key_name,
    #       attribute_type: "N",
    #     }
    #   ],
    #   key_schema: [
    #     {
    #       attribute_name: hash_key_name,
    #       key_type: "HASH"
    #     }
    #   ],
    #   provisioned_throughput: {
    #     read_capacity_units: 5,
    #     write_capacity_units: 5,
    #   }
    # }

    # $dynamodb.create_table(params)
  end

  def self.create_thing_rule(sensor)
    # table_name = sensor.device_EUI

    # return if self.thing_rule_exists?("#{table_name}_rule")

    # role_arn = "arn:aws:iam::552481077848:role/iot_exec_role_671wo"
    # hash_key = "timestamp"
    # hash_value = "${state.reported.ts}"
    # hash_type = "NUMBER"
    # sql_query = "SELECT state.reported.data as data, state.reported.devEUI as devEUI, state.reported.ts as ts FROM '$aws/things/#{table_name}/shadow/update'"

    # dynamodb = {
    #   table_name: table_name,
    #   role_arn: role_arn,
    #   hash_key_field: hash_key,
    #   hash_key_value: hash_value,
    #   hash_key_type: hash_type,
    # }

    # params = {
    #   rule_name: "#{table_name}_rule",
    #   topic_rule_payload: {
    #     sql: sql_query,
    #     actions: [
    #       dynamo_db: dynamodb
    #     ],
    #     rule_disabled: false,
    #   },
    # }

    # $iot.create_topic_rule(params)
  end

  def self.delete_thing(sensor)

    # name = sensor.device_EUI

    # if self.thing_exists?(name)
    #   $iot.delete_thing({
    #     thing_name: name
    #   })
    # end
  end

  def self.delete_thing_database(sensor)

    # table_name = sensor.device_EUI

    # if self.table_exists?(table_name)
    #   $dynamodb.delete_table({
    #     table_name: table_name
    #   })
    # end
  end

  def self.delete_thing_rule(sensor)

    # thing_rule = "#{sensor.device_EUI}_rule"

    # if self.thing_rule_exists?(thing_rule)
    #   $iot.delete_topic_rule({
    #     rule_name: thing_rule
    #   })
    # end
  end

  def self.thing_exists?(thing_name)
    # $iot.list_things.things.each do |thing|
    #   return true if thing.thing_name == thing_name
    # end
    # false
  end

  def self.table_exists?(table_name)
    # $dynamodb.list_tables.table_names.each do |table|
    #   return true if table == table_name
    # end
    # false
  end

  def self.thing_rule_exists?(thing_rule)
    # $iot.list_topic_rules.rules.each do |rule|
    #   return true if rule.rule_name == thing_rule
    # end
    # false
  end

  def self.scan_dynamodb(sensor)

    # table_name = sensor.device_EUI

    # query_params = {
    #   table_name: table_name
    # }

    # $dynamodb.scan(query_params)
  end

  class Error < StandardError

    attr_reader :message

    def initialize(message)
      @message = message
    end
  end

end
