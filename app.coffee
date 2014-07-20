app = (require 'express')()
server = (require 'http').createServer app 
io =(require 'socket.io').listen server

app.get '/',(req,res)->
	res.sendfile __dirname+'/index.html'

app.get '/js/*',(req,res)->
	res.sendfile __dirname+req.path

app.get '/css/*',(req,res)->
	res.sendfile __dirname+req.path

server.listen 8080
