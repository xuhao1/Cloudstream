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
speed={}
class port
	constructor : (@name)->
		@speed=0
		@last={}
	update:(aport)->
		@speed = aport['transmitBytes']+aport['receiveBytes']-@last['transmitBytes']-@last['receiveBytes']
		@last=aport

class machine
	constructor: (@name) ->
		@ports={}
		@speed=0
	update: (portlist)->
		for aport in portlist
			name=aport["portNumber"]
			if @ports[name] is undefined
				@ports[name]=new port name
				@ports[name].last=aport
			else
				@ports[name].update(aport)
		@speed=0
		i=0
		for port of @ports
			@speed +=@ports[port].speed
			speed[i]=@ports[port].speed
			i++

proc =(str)->
	json=eval("("+str+")")
	for name of json
		if cluster[name] is undefined
			cluster[name]=new machine name
		cluster[name].update json[name]
	

run= ->
	a=http.request opt,cb
	a.end()

setInterval run,1000
update= (socket)->
	data={'speed':speed}
	socket.send JSON.stringify(data)

exports.update=update
