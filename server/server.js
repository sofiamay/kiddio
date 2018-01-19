import express from 'express';
import bodyParser from 'body-parser';
import routes from './routes';


const server = express();
const router = routes;

server.use(express.static(`${__dirname}/../../client`));

server.use(bodyParser.json());
server.use(bodyParser.urlencoded({
  extended: true,
}));

app.use(routes);


server.listen(port, () => {
  console.log(`The server is running at http://localhost:${port}`);
});