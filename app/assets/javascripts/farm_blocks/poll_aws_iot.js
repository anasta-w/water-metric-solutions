function poll (params) {

  // console.log("==Poll==", params)
  
  var requestOptions = {
      url: '/data',
      method: 'POST',
      data: params,
      dataType: 'json'
    };

  var xmlResponse = $.ajax(requestOptions);

  xmlResponse.done(function(response){

    var devices = response.devices  

    // console.log("=DEVICES==", devices);

    for (var i in devices.water_tanks){
      var waterTank = devices.water_tanks[i];
      loadGauge(waterTank, i, waterTank.type);
    }
    for (var i in devices.inflow_meters){
      var inflowMeter = devices.inflow_meters[i];
      loadGauge(inflowMeter, i, inflowMeter.type);
    }

  }).fail(function(error){
    console.log(error);
  })

  setTimeout(function(){
    poll(params)
  }, 30000);

};
