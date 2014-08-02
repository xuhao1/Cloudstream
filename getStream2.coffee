speed={}

addMachine=(name)->
	speed[name]={}
	speed[name]["Queue0"]=[]
	speed[name]["Queue1"]=[]
	for a of speed[name]
		q=speed[name][a]
		q[0]=0
		q[1]=0

mkrandom=(name)->
	for a of speed[name]
		q=speed[name][a]
		q[0]=Math.random()*100
		q[1]=Math.random()*100


run=->
	for a of speed
		mkrandom(a)

setInterval run,1000

addMachine "Yang"
addMachine "Qixin"

update = (socket)->
	data={'speed':speed}
	socket.send JSON.stringify(data)

exports.update=update


