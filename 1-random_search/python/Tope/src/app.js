var path = require('path');
var express = require('express');
var bodyParser = require('body-parser');
var reactViews = require('express-react-views');
// initialize spawn variables
var spawn = require('child_process').spawn;
var py_process = spawn('python', ['random_search.py']);
var routes = require('./routes');
var randomData = [];
var outputStr = '';

// setup app
// using express as frame work
var app = express();

//view engine
app.set('views', __dirname + '/views');
app.set('view engine', 'jsx');
app.engine('jsx', reactViews.createEngine());


// communicate with python process
// app recieves data from python process
py_process.stdout.on('data', function(randomData){
  outputStr += randomData.toString();
});

// on stream end log data recieved
py_process.stdout.on('end', function() {
  console.log('Sum = ', outputStr);
  app.set('sum', outputStr);
});

// Stringify data and dump data on to the python process
py_process.stdin.end();

// set port from env with default
app.set('port', (process.env.PORT || 3000));
app.use('/', express.static(path.join(__dirname, 'public')));

// setup body parser
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

app.get('/', routes.index);

// start listening on port on localhost:3000
app.listen(app.get('port'), function() {
  console.log('Server started: http://localhost:' + app.get('port') + '/');
});