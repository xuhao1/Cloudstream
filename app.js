// Generated by CoffeeScript 1.7.1
(function() {
  var app, io, log, run, server;

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

  run = (require('./getStream2')).update;

  log = function(socket) {
    var jsonmes;
    jsonmes = {
      type: "log",
      msg: "MissU\n"
    };
    return socket.send(JSON.stringify(jsonmes));
  };

  io.sockets.on('connection', function(socket) {
    var opt;
    console.log("Connected");
    opt = {
      type: "setup",
      machines: {
        m0: {
          num: 2,
          name: "Yang"
        },
        m1: {
          num: 2,
          name: "Qixin"
        }
      }
    };
    socket.send(JSON.stringify(opt));
    setInterval(run, 1000, socket);
    return setInterval(log, 3000, socket);
  });

  server.listen(8080);

}).call(this);
