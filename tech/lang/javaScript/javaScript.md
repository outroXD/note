# JavaScript


# 基本
## 変数宣言
|  宣言方法  |  再代入  | 再宣言 | スコープ単位 |
| ---- | ---- | ---- | ---- |
|  var  |  ○  | ○ | 関数 |
|  let  |  ○  | × | ブロック |
| const | × | × | ブロック |

* 原則constを使用する。再代入が必要な時のみletを使用する。var使うメリットない。



## プリミティブ型
| 型 | 値 | メモ |
| ---- | ---- | --- |
| Boolean | true/false | |
| Number | 少数を含む数値 | 最大値は9,007,199,254,740,991 |
| BigInt | Numberよりも大きな数値 | ES2020より |
| String | | |
| Symbol | | |
| Null | | nullは何のデータも存在しないことを表す |
| Undefined | 宣言のみ行われた変数、存在しないプロパティへのアクセス | |

* false的な値
  * `false`, `0`, `NaN`, `''`, `null`, `undefined`



## オブジェクト型とそのリテラル
* 配列リテラル
  * `[1, 2, 3]`
* オブジェクトリテラル
  * Object型のインスタンスとして生成される。
  * `{key : value}`
  * 他の言語でいうHashとしてのデータ構造は`狭義のオブジェクト`と呼ばれる。
  * 一方`広義のオブジェクト`は継承元にObjectオブジェクトを持つ。
* 正規表現リテラル
  * RegExpオブジェクトのインスタンスとして生成される。  
  * `/pattern/ig`
    
    

## 関数
* JavaScriptの関数は文/式どちらとしても定義可能。
* 関数も巻き戻しがあるので、const/let必須。
### 宣言
* Functionインスタンス生成
  ```javascript
  const sum = Function('n', 'm', 'return n + m;');
  ```
* 関数式
  ```javascript
  const add = function (n, m) {
    return n + m;
  };
  ```
* アロー関数式
  ```javascript
  const addOne = (n) => {
    return n + 1;
  }
  ```
* 無名関数
  ```javascript
  (function (){})
  ```
  * 名前がないからメモリに残らない。変数に代入しなければ定義した瞬間消える。
* 無名関数 + 変数に代入
  ```javascript
  const test1 = function (){ console.log('test1'); };
  ```
  ```javascript
  const test1 = () => { console.log('test1'); };
  ```



## クラス
### プロトタイプベース
* プロトタイプベースでは、オブジェクトは直接他のオブジェクトを継承する。その時継承元になったオブジェクトをプロトタイプという。
* プロトタイプは`__proto__`に格納されている。
### thisについて
* JavaScriptにおけるthisは「グローバル変数だが、関数内では実行時に呼び出し側から暗黙的に与えられる引数」と考えると良い。
  * Pythonではメソッドの第一引数selfと明示的に書く必要がある。



## 構文
* プロパティ名のショートハンド
  ```javascript
  const baz = 10000;
  const obj2 = { baz };
  ```
* 分割代入
  ```javascript
  const [n, m] = [1, 4];
  console.log(n, m);
  ```
  ```javascript
  const response = {
      data: [
      {
        id: 1,
        name: 'Patty Rabbit',
        email: 'patty@maple.town', },
      {
        id: 2,
        name: 'Rolley Cocker',
        email: 'rolley@palm.town', },
      {
        id: 3,
        name: 'Bobby Bear',
        email: 'bobby@maple.town', },
    ],
  };
  const { data : users = [] } = response;
  ```
* ショートサーキット評価
  ```javascript
  const hello = undefined || null || 0 || NaN || '' || 'Hello!';
  // undefined
  ```
  * 左辺がfalseだと、右辺に値を渡していく
  ```javascript
  const chao = ' ' && 100 && [] && {} && 'Chao!';
  ```
  * 左辺がtrueだと、右辺に値を渡していく
  

## 参考
* [Airbnb Style Guide](https://github.com/airbnb/javascript)