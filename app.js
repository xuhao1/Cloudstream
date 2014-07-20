// Generated by CoffeeScript 1.7.1
(function() {
  var app, io, server;

  app = (require('express'))();

  server = (require('http')).createServer(app);

  io = (require('socket.io')).listen(server);

  app.get('/', function(req, res) {
    return res.sendfile(__dirname + '/index.html');
  });

  app.get('/js/*', function(req, res) {
    return res.sendfile(__dirname + req.path);
  });

  app.get('/css/*', function(req, res) {
    return res.sendfile(__dirname + req.path);
  });

  server.listen(8080);

}).call(this);
