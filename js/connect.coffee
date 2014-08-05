speed={}
gspeed={}
vmindex={}
vmnumbe=0
update = (name,dataset,x)->
	#x=(new Date() ).getTime()
	mspeed=gspeed[name]
	console.log JSON.stringify gspeed
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

send_json=(mes)->
	json=eval '('+mes+')'
	if ("type" of json) and (json["type"] is "setup")
		for name of json["machines"]
			console.log name
			$("#main").append "<div id='#{ name }' class ='col-md-6 machine'></div>"
			mkchart "#"+name,update,json["machines"][name]
	else if ("type" of json) and (json["type"] is "log")
			$("#log").append json["msg"]
	else
		gspeed=json['speed']

#Below is example to use it
opt=
	type:"setup"
	machines:
		m0:
			num:2
			name:"Qiao"
		m1:
			num:2
			name:"Chu"

send_json JSON.stringify opt

speed={}
addMachine=(name)->
	speed[name]={}
	speed[name]["Queue0"]=[]
	speed[name]["Queue1"]=[]
	for a of speed[name]
		q=speed[name][a]
		q[0]=0
		q[1]=0

addMachine "Qiao"
addMachine "Chu"

mkrandom=(name)->
	for a of speed[name]
		q=speed[name][a]
		q[0]=Math.random()*100
		q[1]=Math.random()*100


run=->
	for a of speed
		mkrandom(a)
	data={'speed':speed}
	send_json JSON.stringify data

setInterval run,1000

