app = (require 'express')()
server = (require 'http').createServer app 
io =(require 'socket.io').listen server
app.get '/',(req,res)->
	res.sendfile __dirname+'/index.html'

app.get '/js/*',(req,res)->
	res.sendfile __dirname+req.path

app.get '/css/*',(req,res)->
	res.sendfile __dirname+req.path

run=(require './getStream').update

io.sockets.on 'connection', (socket)->
	console.log "Connected"
	#cb = -> run socket
	setInterval run,1000,socket

server.listen 8080
