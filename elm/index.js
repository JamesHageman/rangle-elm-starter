import './styles/index.css';

import { Main } from './Main';

const root = document.getElementById('root');

const app = Main.embed(root);

app.ports.setPath.subscribe((path) => {
  window.location.hash = path;
  app.ports.pathUpdates.send(path);
});

const sendPath = () => {
  const path = window.location.hash.slice(1);
  app.ports.pathUpdates.send(path);
};

window.onhashchange = sendPath;

if (window.location.hash === '') {
  window.location.hash = '/';
}

setTimeout(sendPath, 0);
