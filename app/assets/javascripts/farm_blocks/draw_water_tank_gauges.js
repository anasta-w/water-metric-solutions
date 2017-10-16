
function drawWaterTankGauges (devices) {

  for (var i in devices){
    var device = devices[i];
    initWTHC(device.capacity, i);
  }

}

var initWTHC = function (capacity, chartId) {

  $('#water-tank' + chartId).highcharts({

      chart: {
        type: 'gauge',
        // Edit chart spacing
        spacingBottom: 15,
        spacingTop: 15,
        spacingLeft: 10,
        spacingRight: 10,
      },

      title: {
        text: ''
      },

      plotOptions: {
        gauge: {
          innerRadius: '80%',
        },
      },

      pane: {
        size: '100%',
        startAngle: -150,
        endAngle: 150,
      },

      credits: {
        enabled: false
      },

      // the value axis
      yAxis: {
          min: 0,
          max: capacity,

          labels: {
              step: 2,
              rotation: 'auto',
              distance: -35,
          },

          plotBands: [{
              from: 0,
              to: (capacity/10),
              color: '#DF5353' // red
            }, {
              from: capacity/10,
              to: (capacity/10) * 3,
              color: '#DDDF0D' // yellow
            }, {
              from: (capacity/10) * 3,
              to: capacity,
              color: '#55BF3B' // green
            }]
        },

      series: [{
          name: 'Water Level',
          data: [0],
          tooltip: {
            valueSuffix: ' L'
          },
          dataLabels: {
            className: 'dataLabels',
          },
      }]

  });

}
