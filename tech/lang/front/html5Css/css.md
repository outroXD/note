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
* 高さを指定できない。
  * 高さ・幅を指定したい場合は`display:block`や`display:inline-block`を指定する。

# スタイル
## display
* インライン要素に高さや幅を持たせたいときに指定する。
* 値
  * `block`
  * `inline-block`
    
## transition
* CSSプロパティが変化する際のアニメーション速度を制御する。

# レスポンシブ
* 複数の端末の画面に対するスタイルを1CSSで記述する際のテクニック。
PCをベースにCSSを作成する場合。
## 画面サイズに応じて当てるCSSを変える
```css
/* PC用のCSSはメディアクエリの外に記述する */

@media screen and (max-width: 959px) {
	/* 959px以下に適用されるCSS（タブレット用） */
}
@media screen and (max-width: 480px) {
	/* 480px以下に適用されるCSS（スマホ用） */
}
```
スマホをベースにCSSを作成する場合。
```css
/* スマホ用のCSSはメディアクエリの外に記述する */

@media screen and (min-width: 481px) {
	/* 481px以上に適用されるCSS（タブレット用） */
}
@media screen and (min-width: 960px) {
	/* 960px以上に適用されるCSS（PC用） */
}
```
## 要素の縦揃え
* IE9以上のモダンブラウザがターゲットの時のみ有効。
```css
display: flex;
justify-content: center;
align-items: center;
```
## 要素を非表示
* PCサイトでは非表示にしたいが、スマホサイトでは表示したいような要素がある場合がある。
* `display:none;`をメディアクエリーと合わせて使う。
```css
対象の要素名 {
  display: none;
}
```
## 背景の設定
```css
height: 500px;
background-image: url("../img/main.jpg");
```
上記設定だと、下記スクショのように繰り返されてしまう。  
CSSを追加して整える。  
<img src="../../../../resource/tech/lang/front/front_01.png">
```css
height: 500px;
background-image: url("../img/main.jpg");
background-position: center;
background-size: cover;
```
<img src="../../../../resource/tech/lang/front/front_02.png">  

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