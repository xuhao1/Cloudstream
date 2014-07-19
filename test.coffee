stdin = process.openStdin()
stdin.setEncoding 'utf8'

stdin.on 'data', (input) -> 
    name = input.trim() 
    process.exit() if name == 'exit' 
    console.log "Hello #{name}"
    console.log "Enter another name or 'exit' to exit"
console.log 'Enter your name'
###
var options = {
  host: 'www.random.org',
  path: '/integers/?num=1&min=1&max=10&col=1&base=10&format=plain&rnd=new'
};

callback = function(response) {
  var str = '';

  //another chunk of data has been recieved, so append it to `str`
  response.on('data', function (chunk) {
    str += chunk;
  });

  //the whole response has been recieved, so we just print it out here
  response.on('end', function () {
    console.log(str);
  });
}

http.request(options, callback).end();
###
