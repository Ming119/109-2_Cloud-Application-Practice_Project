//
//
//

const ExpressMVC = require('express_mvc');

app = new ExpressMVC.App({
	port: 80,
	ip:   '127.0.0.1',
	access_logging: true,
	access_log_dir: './logs/',
	parse_body: {
		json: true,
		urlencoded: {
			extended: true
		}
	}

});


router = new ExpressMVC.Router;
util   = new ExpressMVC.Util;

var http = require('http');

http.createServer(function (req, res) {
	res.writeHead(200, {'Content-Type': 'text/html'});
	res.end('Hello World!');
}).listen(8080);


