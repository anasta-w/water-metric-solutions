/*
//= require charts/draw_line_chart
//= require charts/charts
//= require charts/sensor_data
//= require highstock
*/

$(document).ready(function(){

  // var data = generateData(60);

  LineChart()

  // drawLineChart("chart", gon.water_tank.capacity, data.data, data.pointStart);

});


function LineChart () {
  // console.log("==gon data==", gon.water_tank.data);

  var daysSelected, hours, chartData, timeBack;
  var currentTime = Date.now();

  // By default and on page load, set day to 60.
  daysSelected = 60

  timeBack = charts.calculatePastTimestamp(daysSelected);

  hours = daysSelected * 24;

  var minutes = charts.convertHoursToMinutes(hours);

  chartData = initialiseChartData (minutes);

  // var sensorData = gon.water_tank.data.map(function(entry){
  //   return new SensorData (entry.volume, null, entry.timestamp);
  // })

  var sensorData  = gon.water_tank.data;
  var dataWithinDate = getDataByDate (sensorData, daysSelected);

  for (var i = 0; i < dataWithinDate.length; i++) {
    var dataPos = findDataPosition (dataWithinDate[i], timeBack);
    // console.log(dataWithinDate[i].data.calculated);

    chartData[dataPos] = parseInt(dataWithinDate[i].data);

  }

  var lastReading = 0
  var blanks = 0 // keep a record of 0 values following an acutal data value


  for (var i = 0; i < chartData.length; i++){
    if (chartData[i] != 0) {
      lastReading = chartData;
    }

    else {
      if (blanks < 2) {
          chartData[i] = lastReading;
          blanks += 1;
        } else {
          blanks = 0;
        }
      }
  }

  drawLineChart("chart", gon.water_tank.capacity, chartData, timeBack);
}

function initialiseChartData (minutes = 1440) {

  // Create an array the length of this functions parameter
  var dataContainer = [];

  for (var i = 0; i < minutes; i++) {
    dataContainer.push(0);
  }
  return dataContainer;
}

function getDataToday (data) {

  // iterate through all data
  return data.map( function (dataEntry) {

    // give back the data entry if its timestamp is before 24 hours ago epoch-timewise
    if (dataEntry.isToday())
      return dataEntry

    // else ignore the data entry

  }) // returns an array of data entries and undefined values

  .filter(function(entry) { return entry != undefined }) // clean up all "undefined"s in the array

}

function getDataByDate (data, daysBack) {
  var pastTime = charts.calculatePastTimestamp(daysBack);

  return data.map(function (dataEntry) {
    if (dataEntry.isAfter(pastTime))
      return dataEntry;
  }).filter(function(entry) { return entry != undefined })
}

function findDataPosition (data, timeBack) {

  // data container must already be sorted chronologically
    var dataPosInDay = charts.calculateTimeInDay(data.timestamp, timeBack)

    return dataPosInDay;
}
