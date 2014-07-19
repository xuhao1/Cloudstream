http = require "http"

opt = {
	host:"202.38.88.62",
	path:"/wm/core/switch/00:00:00:00:00:00:00:01/port/json",
	port:8010
}

cb = (res)->
	str = ''
	res.on 'data',(chunk)->
		str = str+chunk
	res.on 'end', (chunk)->
		proc str
cluster={}
class machine
	constructor: (@name) ->
		@ports={}
	procpermachine: (portlist)->

		for aport in portlist
			port_num = aport["portNumber"]
			if @ports[port_num] isnt undefined
				port=@ports[port_num]
				port.speed = aport['transmitBytes']+aport['receiveBytes']-port.last['transmitBytes']-port.last['receiveBytes']

			else
				@ports[port_num] = {}
				@ports[port_num].speed = 0
			
			@ports[port_num].last = aport
			@ports[port_num].last.time = 0
		speed=0
		for port of @ports
			speed +=@ports[port].speed

		machine.speed=speed
		console.log speed

proc =(str)->
	json=eval("("+str+")")
	for name of json
		procpermachine name,json[name]
	

run= ->
	a=http.request opt,cb
	a.end()
	console.log "Tick"
setInterval run,1000
