function drawLineChart (chartElement = "chart", yMax, data, pointStart) {

  var isMobile = {
    Android: function() {
        return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
        return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
        return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
        return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
  };

  var checkMobile = isMobile.any();

  var navigatorEnabled = true;

  if( isMobile.any() ) {
    navigatorEnabled = false;
  }

$('#' + chartElement).highcharts("StockChart", {
      chart: {
          type: 'line',
          zoomType: 'x',
          backgroundColor: 'black',
      },

      title: {
          text: ''
      },

      navigator: {
        enabled: navigatorEnabled,
      },

      subtitle: {
          text: '',
      },

      legend: {
          align: 'right',
          verticalAlign: 'middle',
          layout: 'vertical'
      },

      xAxis: {
        type: "datetime",
      },

      yAxis: {
        min: 0,
        max: yMax,
      },

      series: [{
        type: "line",
        name: "Chart",
        data: data, // data must be an array
        pointStart: pointStart, // Epoch Time
        pointInterval: 60000, // 60 seconds in milliseconds
        pointIntervalUnit: 'minute',
      }],

      tooltip: {
        valueDecimals: 1,
        valueSuffix: 'L'
      },

      rangeSelector: {
        buttons: [{
          type: 'day',
          count: 1,
          text: 'd'
        }, {
          type: 'week',
          count: 1,
          text: '1w'
        }, {
          type: 'month',
          count: 1,
          text: '1m'
        }, {
          type: 'day',
          count: 60,
          text: '60d'
        }, {
          type: 'all',
          text: 'All'
        }],
        selected: 1
      },

      responsive: {
          rules: [{
              condition: {
                  maxWidth: 500
              },
              chartOptions: {
                  legend: {
                      align: 'center',
                      verticalAlign: 'bottom',
                      layout: 'horizontal'
                  },
                  yAxis: {
                      labels: {
                          align: 'left',
                          x: 0,
                          y: -5
                      },
                      title: {
                          text: null
                      }
                  },
                  subtitle: {
                      text: null
                  },
                  credits: {
                      enabled: false
                  }
              }
          }]
      }
  });
}
