document.querySelector('button').addEventListener('click', function(evt) {
  this.textContent = this.textContent === '隐藏' ? '显示' : '隐藏';
  document.querySelector('html').classList.toggle('loading');
}, false);