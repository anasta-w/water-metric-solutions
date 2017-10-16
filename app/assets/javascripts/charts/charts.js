
var charts = (function() {

  var generatePointStart = function generatePointStart(timeNow, timeBack) {
    var timeBackMilli = timeBack * 60 * 1000;
    return timeNow - timeBackMilli;
  }

  var convertHoursToMinutes = function convertHoursToMinutes(hours) {
    return hours * 60;
  }

  var convertDaysToHours = function convertDaysToHours(days) {
    return days * 24;
  }

  var calculateTimeInDay = function calculateTimeInDay (timestamp, yesterday) {
    var test = Math.round((timestamp - yesterday) / 1000)
    return Math.round(test / 60)
  }

  var calculatePastTimestamp = function calculatePastTimestamp (daysBack) {
    var currentTime = Date.now();
    var hoursBack = convertDaysToHours(daysBack);
    var minutesBack = convertHoursToMinutes(hoursBack);
    return generatePointStart (currentTime, minutesBack);
  }

  var yesterday = function yesterday () {
    var currentTime = Date.now();
    var minutesInDay = 1440;
    return generatePointStart(currentTime, minutesInDay);
  }

  var convertEpochToProperTime = function convertEpochToProperTime (utcMilliseconds) {
    var date = new Date(utcMilliseconds);
    return date;
  }

  return {
    generatePointStart: generatePointStart,
    convertHoursToMinutes: convertHoursToMinutes,
    convertDaysToHours: convertDaysToHours,
    calculateTimeInDay: calculateTimeInDay,
    calculatePastTimestamp: calculatePastTimestamp,
    yesterday: yesterday,
    convertEpochToProperTime: convertEpochToProperTime
  }

})();
