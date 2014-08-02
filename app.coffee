app = (require 'express')()
server = (require 'http').createServer app 
io =(require 'socket.io').listen server
app.get '/',(req,res)->
	res.sendfile __dirname+'/index.html'

app.get '/js/*',(req,res)->
	res.sendfile __dirname+req.path

app.get '/css/*',(req,res)->
	res.sendfile __dirname+req.path

run=(require './getStream2').update


log=(socket)->
	jsonmes=
		type:"log"
		msg : "MissU\n"
	socket.send JSON.stringify(jsonmes)

io.sockets.on 'connection', (socket)->
	console.log "Connected"
	#此处设置VM数量和
	opt=
		type:"setup"
		machines:
			m0:
				num:2
				name:"Yang"
			m1:
				num:2
				name:"Qixin"
	socket.send JSON.stringify(opt)
	#cb = -> run socket
	setInterval run,1000,socket
	setInterval log,3000,socket
server.listen 8080
