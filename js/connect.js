// Generated by CoffeeScript 1.7.1
(function() {
  var init_connect, speed, update, vmindex, vmnumbe;

  speed = {};

  vmindex = {};

  vmnumbe = 0;

  update = function(name, dataset, x) {
    var count0, count1, mspeed, num, q0, q1, sum0, sum1, vm, _results;
    mspeed = speed[name];
    console.log(mspeed);
    q0 = mspeed["Queue0"];
    q1 = mspeed["Queue1"];
    count0 = 0;
    count1 = 0;
    sum0 = 0;
    sum1 = 0;
    num = q0.length;
    for (vm in q0) {
      sum0 += q0[vm];
    }
    for (vm in q1) {
      sum1 += q1[vm];
    }
    _results = [];
    for (vm in q0) {
      dataset[vm].addPoint([x, sum0 - count0], true, true);
      count0 += q0[vm];
      count1 += q1[vm];
      _results.push(dataset[2 * num - vm - 1].addPoint([x, -count1], true, true));
    }
    return _results;
  };

  init_connect = function(data) {
    var socket;
    socket = io.connect(document.domain);
    socket.on('connect', function() {
      return console.log("Connected");
    });
    socket.on("disconnect", function() {
      return console.log("disConnect");
    });
    return socket.on("message", function(mes) {
      var json, name;
      json = eval('(' + mes + ')');
      console.log(mes);
      if (("type" in json) && (json["type"] === "setup")) {
        for (name in json["machines"]) {
          console.log(name);
          $("#main").append("<div id='" + name + "' class ='col-md-6 machine'></div>");
          mkchart("#" + name, update, json["machines"][name]);
        }
      }
      if (("type" in json) && (json["type"] === "log")) {
        return $("#log").append(json["msg"]);
      } else {
        return speed = json['speed'];
      }
    });
  };

  init_connect();

}).call(this);
