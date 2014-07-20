speed={}
update = (dataset,x)->
	#x=(new Date() ).getTime()
	y=speed
	dataset[0].addPoint [x,y[0] ],true,true
	dataset[1].addPoint [x,y[1] ],true,true
	dataset[2].addPoint [x,y[2] ],true,true
	console.log x+y
init_connect = (data)->
	socket = io.connect document.domain
	socket.on 'connect',()->
		mkchart("#container",update)
		console.log("Connected")
	socket.on "disconnect",()->
		console.log("disConnect")
	socket.on "message",(mes)->
		json=eval('('+mes+')')
		speed=json['speed']
init_connect()


