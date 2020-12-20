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
  


## thisについて
### 1. new演算子をつけて呼び出し
* JavaScriptにおけるthisは「グローバル変数だが、関数内では実行時に呼び出し側から暗黙的に与えられる引数」と考えると良い。
  * Pythonではメソッドの第一引数selfと明示的に書く必要がある。
* `new`演算子
  1. prototypeオブジェクトをコピーする。
  2. 引数thisとして関数に渡す。
### 2. メソッドとして実行したとき
* メソッドとして実行されたとき、そのアクセス演算子`.`の前のオブジェクトが`this`に入る。
### 3. (1), (2)以外の関数/非Strictモード
* ブラウザなら`Window`オブジェクト、Node.jsなら`global`を指す。
### 4. (1), (2)以外の関数/非Strictモード
* new演算子を使わずに関数を定義すると、グローバルオブジェクトにプロパティが追加されてします。
  * `use strict`を使えば制限できる。
* `use strict`を使うと、関数がオブジェクトのコンテキストにない中定義された場合、値がundefinedになる。
```javascript
'use strict';
const Person = function (name) {
    this.name = name;
}
Person('keisuke');  // undefinedなので、Uncaught TypeErrorで通らない
```
### class + this
メソッド内関数の実行コンテキストはオブジェクトではない。  
`use strict`しているので、関数にはundefinedが入る。  
なのでgreet()の呼び出しで例外が起こる。
```javascript
'use strict';
class Person {
    constructor (name) {
        this.name = name;
    }
    
    greet () {
      const doIt = function () {
        console.log(`${this.name}が挨拶をした。`);
      };
      doIt();
    };
};
```
上記問題に対して以下のように定義することで回避できる。
```javascript
class Person {
    constructor (name) {
        this.name = name;
    }
    
    greet1 () {
        const doIt = function () {
            console.log(`${this.name}が挨拶をした。`)
        };
        const bindedDoIt = doIt.bind(this);
        bindedDoIt();
    };
    
    greet2 () {
        const doIt = function () {
            console.log(`${this.name}が挨拶をした。`);
        };
        doIt.call(this);
    };
    
    greet3 () {
        const _this = this;
        const doIt = function () {
            console.log(`${_this.name}が挨拶をした。`);
        };
        doIt();
    }
    
    greet4 () {
        const doIt = () => {
            cosole.log(`${this.name}が挨拶をした。`);
        };
        doIt();
    };
    
    greet5 = () => {
        const doIt = () => {
            console.log(`${this.name}が挨拶をした。`);
        };
        doIt();
    };
};
```
`greet4`, `greet5`(アロー関数式)の定義は、`this`のコンテキストを暗黙的に外側のスコープのthisの値を参照するようになる。  
言語仕様的な一貫性はないが、他の言語に慣れている場合は直感的に使用できる。  

* thisはクラス構文内でしか使わない。
* クラス構文内では、メソッドを含めたあらゆる関数定義をアロー関数式で行う。



# 関数型プログラミング on JavaScript
## コレクション反復
| 関数 | 引数 | メモ |
| ---- | ---- | --- |
| map() | | 対象の配列の要素一つ一つを任意に加工した新しい配列を返す |
| filter() | | 与えた条件に適合する要素だけを抽出した新しい配列を返す |
| find() | | 与えた条件に適合した最初の要素を返す。見つからない場合はundefinedを返す |
| findIndex() | | 与えた条件に適合した最初の要素のインデックスを返す。 見つからない場合は-1を返す |
| every() | | 与えた条件を全ての要素が満たすかを真偽値で返す |
| some() | | 与えた条件を満たす要素が一つでもあるかを真偽値で返す |
| reduce() | 第一引数:前回の関数の実行結果 第二引数:配列の各要素 | 前回の実行結果(第一引数)に対して、今回の値(第二引数)を作用させた結果を返す |
| sort() | |  |
| includes() | | |



## 参考
* [Airbnb Style Guide](https://github.com/airbnb/javascript)