//= require highstock
//= require charts/draw_line_chart
//= require charts/draw_bar_chart
//= require charts/charts
//= require charts/sensor_data

$(document).ready(function(){

  LineChart ();
  BarChart ();

})

function BarChart () {

  var oneDay, one, twoDay, two, threeDay, three, fourDay, four, fiveDay, five, sixDay, six, sevenDay, seven;

  oneDay = charts.calculatePastTimestamp(1);
  twoDay = charts.calculatePastTimestamp(2);
  threeDay = charts.calculatePastTimestamp(3);
  fourDay = charts.calculatePastTimestamp(4);
  fiveDay = charts.calculatePastTimestamp(5);
  sixDay = charts.calculatePastTimestamp(6);
  sevenDay = charts.calculatePastTimestamp(7);

  var week = [oneDay, twoDay, threeDay, fourDay, fiveDay, sixDay, sevenDay];

  one = [];
  two = [];
  three = [];
  four = [];
  five = [];
  six = [];
  seven = [];

  gon.inflow_meter.data.map(function(entry){
    if (entry.timestamp > oneDay)
      one.push(entry.calculated);

    else if (entry.timestamp > twoDay && entry.timestamp < oneDay)
      two.push(entry.calculated);

    else if (entry.timestamp > threeDay && entry.timestamp < twoDay)
      three.push(entry.calculated);

    else if (entry.timestamp > fourDay && entry.timestamp < threeDay)
      four.push(entry.calculated);

    else if (entry.timestamp > fiveDay && entry.timestamp < fourDay)
      five.push(entry.calculated);

    else if (entry.timestamp > sixDay && entry.timestamp < fiveDay)
      six.push(entry.calculated);

    else if (entry.timestamp > sevenDay && entry.timestamp < sixDay)
      seven.push(entry.calculated);
  });


  data = [one, two, three, four, five, six, seven];

  for (var i in data ) {

    if (data[i].length != 0){
      data[i] = data[i].reduce(add);
    }
    else
      data[i] = 0;
  };

  categories = week.map(function(dayTS){
    return charts.convertEpochToProperTime(dayTS);
  });

  DrawBarChart("bar-chart", categories.reverse(), data.reverse(), 1);
}


function add (a, b) {
  var sum = a + b;
  return Math.round(sum);
}

function LineChart () {
  var daysSelected, hours, chartData, timeBack;
  var currentTime = Date.now();

  // By default and on page load, set day to 60.
  daysSelected = 60

  timeBack = charts.calculatePastTimestamp(daysSelected);

  hours = daysSelected * 24;

  var minutes = charts.convertHoursToMinutes(hours);

  chartData = initialiseChartData (minutes);

  var sensorData = gon.inflow_meter.data.map(function(entry){
    var timestamp = entry.timestamp;
    return new SensorData (entry.calculated, null, timestamp);
  })

  var dataWithinDate = getDataByDate (sensorData, daysSelected);

  for (var i = 0; i < dataWithinDate.length; i++) {
    var dataPos = findDataPosition (dataWithinDate[i], timeBack);
    // console.log(dataWithinDate[i].data.calculated);
    var dataValue = parseInt(dataWithinDate[i].data);

    chartData[dataPos] = dataValue;


    // bug hotfix, smooths out data
    if (chartData[dataPos + 1] == 0)
      chartData[dataPos + 1] = dataValue;

    else if (chartData[dataPos - 1] == 0)
      chartData[dataPos - 1] = dataValue;

  }
  var dataHeightValues = dataWithinDate.map(function(entry){
    return entry.data;
  });

  var yMax = calculateYMax(dataHeightValues);
  drawLineChart("chart", yMax, chartData, timeBack);
}

function calculateYMax (data) {

  // declare a variable to hold onto the largest data value in the array
  // defaults to zero
  var max = 0;

  data.map(function(e){

    var sensorReading = parseInt(e);

    if (sensorReading > max)
      max = sensorReading;
  });

  var buffer = 5;

  // add n value to act as a buffer from the roof of the chart
  return max + buffer;

}

function findDataPosition (data, timeBack) {

  // data container must already be sorted chronologically
    var dataPosInDay = charts.calculateTimeInDay(data.timestamp, timeBack)

    return dataPosInDay;
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
