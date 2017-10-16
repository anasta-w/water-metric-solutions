

var SensorData = function (data, datetime, timestamp) {
  this.data = data,
  this.datetime = datetime,
  this.timestamp = timestamp,

  this.isToday = function isToday () {
    if ( this.timestamp > charts.yesterday() )
      return true;
    else
      return false;
  },

  this.isAfter = function isAfter (dateTimestamp) {
    if ( this.timestamp > dateTimestamp )
      return true;
    else
      return false;
  }
  
}
