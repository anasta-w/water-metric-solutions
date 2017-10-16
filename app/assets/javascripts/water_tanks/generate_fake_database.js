
const height = 2.5;
const capacity = 25000;
const radius = calculateRadius(capacity, height);

function generateDataEntry (previousEntry) {
  var data;

  if (parseFloat(previousEntry)){
    var increment = 0.01;
    var randNum = Math.random();

    if (previousEntry <= 0){
      if (randNum > 0.5){
        data = 0;
      } else {
        data = previousEntry + increment;
      }
    } else if (previousEntry >= height){
        if (randNum > 0.5){
          data = 2.5;
        } else {
          data = previousEntry - increment;
        }
    } else {

      if (previousEntry - increment < 0) {
        data = previousEntry + increment;
      } else if (previousEntry + increment > height){
        data = previousEntry - increment;
      } else {
        if (randNum > 0.5) {
          increment = -Math.abs(increment);
        }
        data = parseFloat(previousEntry) + increment;
      }
    }
  } else {
    data = height - (Math.random() * height);
  }

  return parseFloat(data.toFixed(3));

}

function generatePointStart(timeNow, timeBack) {
  var timeBackMilli = timeBack * 60 * 1000;
  return timeNow - timeBackMilli;
}

function calculateVolume(data){

  var data_height = height - data;
  var final_volume_metres_cubed = (Math.PI * data_height) * (radius * radius);
  var final_volume = Math.round(final_volume_metres_cubed * 1000);
  return final_volume;
}

function calculateRadius (capacity, height){

    var result1 = Math.PI * height;
    var volume_meters_cubed = capacity / 1000;
    var result2 = volume_meters_cubed / result1;
    var result3 = Math.sqrt(result2);
    var round_radius = result3.toFixed(2);

    return round_radius;
};

function convertDaysToHours(days) {
  return days * 24;
}

function convertHoursToMinutes(hours) {
  return hours * 60;
}

var days = 60;

var hours = convertDaysToHours(days);
var minutes = convertHoursToMinutes(hours);

function generateData(time, type){

  var currentTime = Date.now();

  var time = time || 1;
  var hours = convertDaysToHours(time);
  var minutes = convertHoursToMinutes(hours);

  var type = type || "day"; //worthless for time-being

  var data = {"data": [], "pointStart": generatePointStart(currentTime, minutes)};
  var previousEntry = null;

  for (var i = 0; i < minutes; i++){
    previousEntry = generateDataEntry(previousEntry);
    var volume = calculateVolume(previousEntry);
    data.data.push(volume);
  }

  return data;
}
