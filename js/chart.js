function mkserie(name)
{
	return {
		name: name,
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
	};
}
function mkseries(json)
{
	var num=json["num"];
	var a=[];
	for (var i=0;i<2*num;i++)
	{
		if (i<num)
			name="Queue0 VM"+i;
		else
			name="Queue1 VM"+(2*num-1-i);
		a[i]=mkserie(name);
	}

	return a;
}
function mkchart(name,update,json) {
	Highcharts.setOptions({
		global: {
			useUTC: false
		}
	});

	var chart;
	$(name).highcharts({
		chart: {
			type: 'areaspline',
		animation: Highcharts.svg, // don't animate in old IE
		marginRight: 10,
		events: {
			load: function() {

				// set up the updating of the chart each second
				var series = this.series;
				setInterval(function() {
					time = (new Date()).getTime();
					update(json["name"],series,time)
				}, 1000);
			}
		}
		},
			title: {
				text: json["name"]
			},
			xAxis: {
				type: 'datetime',
				tickPixelInterval: 100
			},
			yAxis: {
				title: {
					text: 'Speed Percent'
				},
				plotLines: [{
					value: 0,
					width: 1,
					color: '#808080'
				}]
				//,
				//max:100,
				//min:-100
			},
			tooltip: {
				formatter: function() {
					return '<b>'+ this.series.name +'</b><br/>'+
						Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
						Highcharts.numberFormat(this.y, 2);
				}
			},
			plotOptions: {
				areaspline: {
					//stacking: 'percent',
					lineColor: '#ffffff',
					lineWidth: 1,
					marker: {
						lineWidth: 1,
						lineColor: '#ffffff'
					}
				}
			},
			legend: {
				enabled: true
			},
			exporting: {
				enabled: false
			},
			series: mkseries(json)
	});
}
