import React from 'react';
import ReactDOM from 'react-dom';
import App from '../components/App';

document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector('#main');
  if (!container) return;

  ReactDOM.render(<App />, container);
});
