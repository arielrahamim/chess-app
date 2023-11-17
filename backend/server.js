const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const socketio = require('socket.io');
const http = require('http');
const path = require('path');
const { MONGO_URI,SERVER_PORT } = require('./config/config.js');

const app = express();


const server = http.createServer(app);
const io = socketio(server, {
    cors: {
        origin: "*",
        credentials: true,
    },
});

io.on('connection', (socket) => {
    socket.on('join', ({ gameId }) => {
        socket.join(gameId);
        io.to(gameId).emit('userJoined');
    });
    socket.on('postMove', (data) => {
        io.to(data.gameId).emit('receiveMove', data);
    });
});

app.use(express.json());
app.use(cors());

// setting the routers
const gameRouter = require('./routes/gameRouter');
const userRouter = require('./routes/userRouter');
const testRouter = require('./routes/testRouter'); 
// app.use('/g', gameRouter);
app.use('/api/g', gameRouter);
app.use('/api/u', userRouter);
app.use('/api/test', testRouter);

// Serve static assets if in production
if (process.env.NODE_ENV === 'production') {
    app.use(express.static('client/build'));
    app.get('*', (req, res) => {
        res.sendFile(path.resolve(__dirname, 'client', 'build', 'index.html'));
    });
}



// connect to mongodb database
mongoose.connect(
    MONGO_URI,
    { useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex: true },
    (err) => {
        console.log(process.env)
        if (err) throw err;
        console.log('MongoDB is connected');
    }
);

const port = SERVER_PORT || 5000;
server.listen(port, () => {
    console.log(`Server is up and running at port: ${port}`);
});

module.exports = {app,server};