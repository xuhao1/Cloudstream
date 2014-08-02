speed={}
vmindex={}
vmnumbe=0
update = (name,dataset,x)->
	#x=(new Date() ).getTime()
	mspeed=speed[name]
	console.log mspeed
	q0=mspeed["Queue0"]
	q1=mspeed["Queue1"]
	count0=0
	count1=0
	sum0=0
	sum1=0
	num=q0.length
	for vm of q0
		sum0 +=q0[vm]
	for vm of q1
		sum1 +=q1[vm]
	for vm of q0
		dataset[vm].addPoint [x,sum0-count0 ],true,true
		count0+= q0[vm]
		count1+= q1[vm]
		dataset[2*num-vm-1].addPoint [x,-count1 ],true,true


init_connect = (data)->
	socket = io.connect document.domain
	socket.on 'connect',()->
		console.log("Connected")
	socket.on "disconnect",()->
		console.log("disConnect")
	socket.on "message",(mes)->
		json=eval '('+mes+')'
		console.log(mes)
		if ("type" of json) and (json["type"] is "setup")
			for name of json["machines"]
				console.log name
				$("#main").append "<div id='#{ name }' class ='col-md-6 machine'></div>"
				mkchart "#"+name,update,json["machines"][name]
		if ("type" of json) and (json["type"] is "log")
				$("#log").append json["msg"]
		else
			speed=json['speed']
init_connect()


