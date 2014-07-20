app = (require 'express')()
server = (require 'http').createServer app 
io =(require 'socket.io').listen server
app.get '/',(req,res)->
	res.sendfile __dirname+'/index.html'

app.get '/js/*',(req,res)->
	res.sendfile __dirname+req.path

app.get '/css/*',(req,res)->
	res.sendfile __dirname+req.path

run=(socket)->
	speed={}
	speed[0]=Math.random()*100
	speed[1]=Math.random()*100
	speed[2]=Math.random()*100
	data={'speed':speed}
	socket.send JSON.stringify(data)

io.sockets.on 'connection', (socket)->
	console.log "Connected"
	#cb = -> run socket
	setInterval run,1000,socket

server.listen 8080
