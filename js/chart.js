function mkchart(name,update) {
	Highcharts.setOptions({
		global: {
			useUTC: false
		}
	});

	var chart;
	$(name).highcharts({
		chart: {
			type: 'spline',
		animation: Highcharts.svg, // don't animate in old IE
		marginRight: 10,
		events: {
			load: function() {

				// set up the updating of the chart each second
				var series = this.series;
				   setInterval(function() {
					time = (new Date()).getTime(),
					y = Math.random();
				//series.addPoint([x, y], true, true);
				update(series,time)
				}, 1000);
			}
		}
		},
			title: {
				text: 'Live Speed'
			},
			xAxis: {
				type: 'datetime',
				tickPixelInterval: 100
			},
			yAxis: {
				title: {
					text: 'Speed'
				},
				plotLines: [{
					value: 0,
					width: 1,
					color: '#808080'
				}]
			},
			tooltip: {
				formatter: function() {
					return '<b>'+ this.series.name +'</b><br/>'+
						Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
						Highcharts.numberFormat(this.y, 2);
				}
			},
			legend: {
				enabled: false
			},
			exporting: {
				enabled: false
			},
			series: [{
				name: '01Speed',
				data: (function() {
					// generate an array of random data
					var data = [],
				time = (new Date()).getTime(),
				i;

				for (i = -19; i <= 0; i++) {
					data.push({
						x: time + i * 1000,
						y: 0
					});
				}
				return data;
				})()
			},
			{
				name: '02Speed',
				data: (function() {
					// generate an array of random data
					var data = [],
				time = (new Date()).getTime(),
				i;

				for (i = -19; i <= 0; i++) {
					data.push({
						x: time + i * 1000,
						y: 0
					});
				}
				return data;
				})()
			},
			{
				name: '03Speed',
				data: (function() {
					// generate an array of random data
					var data = [],
				time = (new Date()).getTime(),
				i;

				for (i = -19; i <= 0; i++) {
					data.push({
						x: time + i * 1000,
						y: 0
					});
				}
				return data;
				})()
			}]
	});
}
