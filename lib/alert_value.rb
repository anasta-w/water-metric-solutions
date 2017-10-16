module AlertValue

  def create_alert_value(device_EUI, type, value)

    # table_name = 'alert_values'

    # item_params = {
    #   "devEUI": device_EUI,
    #   type: type,
    #   value: value,
    # }

    # params = {
    #   table_name: table_name,
    #   item: item_params,
    # }

    # $dynamodb.put_item(params)

  end

  def attach_lambda_to_thing_rule(thing_name, type )
    # thing_rule = thing_name + "_rule"

    # former_rule = $iot.get_topic_rule({
    #   rule_name: thing_rule
    #   })

    #   dynamodb_rule = former_rule.rule.actions[0].dynamo_db.to_h

    #   lambda_arn = get_alert_type_lambda_arn(type).configuration.function_arn

    #   lambda_params = {
    #     function_arn: lambda_arn
    #   }

    #   params = {
    #     rule_name: thing_rule,
    #     topic_rule_payload: {
    #       sql: "SELECT state.reported.data as data, state.reported.devEUI as devEUI, state.reported.ts as ts FROM '$aws/things/test12345/shadow/update'",
    #       actions: [
    #         {
    #           dynamo_db: dynamodb_rule
    #         },
    #         lambda: {
    #           function_arn: lambda_arn
    #         }
    #       ]
    #     }
    #   }

      begin
        # $iot.replace_topic_rule(params)
      end
  end

  def remove_lambda_from_thing_rule(thing_name)

    # thing_rule = thing_name + "_rule"

    # former_rule = $iot.get_topic_rule({
    #   rule_name: thing_rule
    #   })

    #   dynamodb_rule = former_rule.rule.actions[0].dynamo_db.to_h

    #   params = {
    #     rule_name: thing_rule,
    #     topic_rule_payload: {
    #       sql: "SELECT state.reported.data as data, state.reported.devEUI as devEUI, state.reported.ts as ts FROM '$aws/things/test12345/shadow/update'",
    #       actions: [
    #         {
    #           dynamo_db: dynamodb_rule
    #         }
    #       ]
    #     }
    #   }

      # begin
        # $iot.replace_topic_rule(params)
      # end

  end

  def get_alert_type_lambda_arn(type)

    # function_name = "alert_" + type

    # return $lambda.get_function({
    #   function_name: function_name
    #   })

  end

  def confirm_alert_seen(data, device_EUI)

    # params = {
    #   table_name: device_EUI + "_alerts",
    #   key: {
    #     "data": data.to_s
    #   },
    #   attribute_updates: {
    #     "seen" => {
    #       value: true,
    #       action: "PUT"
    #     }
    #   }
    # }

    # $dynamodb.update_item(params)

  end

end
