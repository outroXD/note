# CSS
# memo
## ブロックレベル要素/インラインレベル要素
### ブロックレベル要素の特徴
* 親要素の大きさが継承される。
* ブロックレベル要素同士は縦に配置される。
* 幅・高さの指定ができる。
* 余白(padding・margin)の指定ができる。
#### ブロックレベル要素の代表的なタグ
* `<div>`
* `<h1>〜<h6>`
* `<p>`
* `<ul>`
* `<ol>`
* `<li>`
* `<dl>`
* `<dt>`
* `<dd>`
* `<nav>`
* `<address>`
* `<header>`
* `<footer>`
* `<main>`
* `<section>`
### インライン要素の特徴
* インライン要素同士は並ぶと横に配置される。

# スタイル
## display
* インライン要素に高さや幅を持たせたいときに指定する。
* 値
  * `block`
  * `inline-block`
    
## transition
* CSSプロパティが変化する際のアニメーション速度を制御する。

# tips
## 「構造」と「見た目」の分離
* 画面要素を「コンポーネント」と言う単位に分割する。
* コンポーネントの「構造」と「見た目」を分離する。
### 悪い例
```html
<div class="success-message">message</div>
<div class="warning-message">message</div>
<div class="error-message">message</div>
```
```css
.success-message {
}
.warning-message {
}
.error-message {
}
```
### 良い例
* 例えばエラーメッセージの見た目だけに変更が入った場合など、他のメッセージのスタイルに影響を与えることなく変更を加えられる。
```html
<div class="success message">message</div>
<div class="warning message">message</div>
<div class="error message">message</div>
```
```css
.message {
}
.success {
}
.warning {
}
.error {
}
```