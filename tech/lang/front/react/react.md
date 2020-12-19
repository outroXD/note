# React

## 後で整理する
* `public/index.html`の`<div id="root"></div>`の中身が、`src/index.tsx`の`RenderDOM.render()`の第二引数`document.getElementById('root')`に紐づく。
  * `RenderDOM.render()`の第一引数はJSXというもの。
* `public/index.html`と`src/index.tsx`は、Babelでコンパイル→webpackでまとめられた結果、`/static/js/main.chunk.js`の中で紐づけられている。
  

* 
* b