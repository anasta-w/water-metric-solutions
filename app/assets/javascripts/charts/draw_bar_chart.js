function DrawBarChart (chartElement = "bar-chart", categories, data, pointStart, yMax) {

  Highcharts.setOptions({
    global: {
      useUTC: false
    }
  });

  $("#" + chartElement).highcharts({

    chart: {
      marginBottom: 100,
      marginTop: 75,
      type: 'column'
    },

    title: {
      text: ''
    },

    legend: {
      enabled: false,
    },

    xAxis: {
      categories: categories,
      crosshair: true
    },

    yAxis: {
      min: 0,
      max: yMax,
      plotLines:[{
        value: gon.inflow_meter.sensor.daily_consent,
        color: '#ff0000',
        width: 2,
        label: {
          text: "Daily Consent: " + gon.inflow_meter.sensor.daily_consent + "L"
        }
      }],

      title: {
        text: ''
      }
    },
    // tooltip: {
    //   headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
    //   pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
    //   '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
    //   footerFormat: '</table>',
    //   shared: true,
    //   useHTML: true
    // },
    plotOptions: {
      column: {
        pointPadding: 0.2,
        borderWidth: 0
      }
    },

    series: [{
      data: data
    }, ],

    credits: {
      enabled: false
    }

  })

}
