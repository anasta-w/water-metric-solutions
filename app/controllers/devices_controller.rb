class DevicesController < ApplicationController
  require "losant_rest"



  def login

    @name=params[:name]
    @description=params[:description]
    @value=params[:value]


    device_info ={
        "name": @name  ,
        "description": @description  ,

        "tags": [
            {
                "key": "SIGFOX_ID",
                "value":@name
            }
        ],
        "attributes": [
            {
                "name": "voltage",
                "dataType": "number"
            }
        ],
        "deviceClass": "standalone"
    }
    #url =  "https://590bc7a2c8f13000014788c5.onlosant.com/devices"
    #response = Net::HTTP.post_form(url,device_info)

   # client = LosantRest::Client.new(auth_token: ENV['LOSANT_API_TOKEN'], url: "https://api.losant.com")
   # registerStatus = client.devices.post(applicationId: ENV['LOSANT_APP_ID'], device: device_info)
    urlApi =  "https://590bc7a2c8f13000014788c5.onlosant.com/devices"
    #59d54e901dd3d200070cd75b
    response = HTTP.post(urlApi, :json => device_info)
    puts @name
    puts @description
    redirect_to ok_path

     end

 # private


end
