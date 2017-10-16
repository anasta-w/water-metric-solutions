var loadGauge = function (device, index, type){

  // reinitialize chart with highcharts functionality
  var gauge = $('#' + type + index).highcharts();

  var refreshGauge = function(gauge, device){    
    checkGaugeStatus(gauge, device.sensor_health);
    // var rawData = JSON.parse(device.shadow.payload.payload).raw;
    // var data = parseInt(atob(rawData));

    // injectDataToGauge(gauge, device.latest_reading.data);
    injectDataToGauge(gauge, device.data);
    
    updateLatestReading(device, index);
  }

  $("#" + type + "-status" + index).html(device.sensor_health.message);

  if (hasData(device.latest_reading)){
    refreshGauge(gauge, device);
  } else {

    checkGaugeStatus(gauge, device.sensor_health);
    $("#sensor-lastReading" + index).html("Never");
  }

  gauge.redraw();
}

var hasData = function(reading){
  if (reading){
    return true
  } else {
    return false
  }
}

var injectDataToGauge = function (gauge, data) {
  gauge.series[0].setData([data]);
}

var checkGaugeStatus = function(gauge, status) {  
  if (!status.online_status){
    gauge.series[0].update({
      dial: {
        backgroundColor: "red"
      }
    });
  }
  else {
    // debugger;
  }
}

var updateLatestReading = function (device, index){
  $("#" + device.type + "-lastReading" + index).html(device.latest_reading.timestamp);
}
