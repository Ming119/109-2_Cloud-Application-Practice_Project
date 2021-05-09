// server.js

require('dotenv').config();
const express = require('express');
const http = require('http');

const app = express();
const server = http.createServer(app);
const port = process.env.PORT;

const userRoute  = require('./routes/User');
const tradeRoute = require('./routes/Trade');

app.use(express.json());
app.use('/user', userRoute);
app.use('/trade', tradeRoute);


app.listen(port, () => {
	console.log(`Server running on port ${port}`);
});
