import './styles/index.css';

import { Main } from './Main';

const root = document.getElementById('root');

const app = Main.embed(root);

app.ports.setPath.subscribe((path) => {
  window.location.hash = path;
  app.ports.pathUpdates.send(path);
});

const sendPath = () => {
  if (window.location.hash === '') {
    window.location.hash = '/';
  }

  const path = window.location.hash.slice(1);
  app.ports.pathUpdates.send(path);
};

window.onhashchange = sendPath;

setTimeout(sendPath, 0);

const storageKey = 'rangle-elm-starter';

app.ports.setSession.subscribe((user) => {
  if (!user) {
    localStorage.removeItem(storageKey);
    return;
  }

  localStorage.setItem(
    storageKey,
    JSON.stringify({ user })
  );
});

const sendSession = () => {
  const data = localStorage.getItem(storageKey);
  if (!data) return;
  const { user } = JSON.parse(data);
  app.ports.sessionInit.send(user);
};

setTimeout(sendSession, 0);
