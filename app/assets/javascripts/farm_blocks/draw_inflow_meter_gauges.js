function drawInflowMeterGauges (devices) {  
  for (var i in devices){
    var device = devices[i];
    initIMHC(i);
  }
}

function initIMHC(id){
  
  var gaugeOptions = {

       chart: {
         type: 'solidgauge',
         // Edit chart spacing
         spacingBottom: 10,
         spacingTop: 10,
         spacingLeft: 10,
         spacingRight: 10,
       },

       title: null,

       pane: {
         size: '100%',
         startAngle: -90,
         endAngle: 90,
         background: {
             backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || '#EEE',
             innerRadius: '60%',
             outerRadius: '100%',
             shape: 'arc'
         }
       },

       tooltip: {
         enabled: true
       },

       // the value axis
       yAxis: {
         stops: [
             [0.1, '#DF5353'], // red
             [0.5, '#DDDF0D'], // yellow
             [0.9, "#55BF3B"] // green
         ],
         lineWidth: 0,
         minorTickInterval: null,
         tickAmount: 2,
         title: {
             y: -70
         },
         labels: {
             y: 35,
         }
       }
     }

   // The speed gauge
   $('#inflow-meter' + id).highcharts(Highcharts.merge(gaugeOptions, {
       yAxis: {
         min: 0,
         max: 60,
       },

       credits: {
         enabled: false
       },

       series: [{
         name: 'Litres Per Minute',
         data: [0],
         tooltip: {
             valueSuffix: ' Lpm'
         },
       }]
   }));

}
