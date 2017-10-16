// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
/*
//= require highcharts
//= require highcharts/highcharts-more
//= require highcharts/modules/solid-gauge
//= require farm_blocks/draw_inflow_meter_gauges
//= require farm_blocks/draw_water_tank_gauges
//= require farm_blocks/load_gauge
//= require farm_blocks/google_maps
//= require farm_blocks/poll_aws_iot
*/


$(document).ready(function(){

	drawWaterTankGauges(gon.water_tanks);
	drawInflowMeterGauges(gon.inflow_meters);

	if (gon.farms) {
	  for (var i = 0, farmCount = gon.farms.length; i < farmCount; i++)
	    drawMap(gon.farms[i]);
	}

	var fbID = window.location.pathname[window.location.pathname.length - 1];	
	var deviceParams = {"id": fbID};

	// console.log("===FARM ID===", deviceParams);

	poll(deviceParams);

});
