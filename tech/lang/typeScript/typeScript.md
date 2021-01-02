# TypeScript

# 基本
## 型アノテーション
```typescript
let n: number = 1;
```



## データ型
### プリミティブ型
| 型 | 値 | メモ |
| ---- | ---- | --- |
| Boolean | true/false | |
| Number | 少数を含む数値 | 最大値は9,007,199,254,740,991 |
| BigInt | Numberよりも大きな数値 | ES2020より |
| String | | |
| Symbol | | |
| Null | | nullは何のデータも存在しないことを表す |
| Undefined | 宣言のみ行われた変数、存在しないプロパティへのアクセス | |
### 配列
```typescript
const numArr: number[] = [1, 2, 3];
```
```typescript
const strArr: Array<string> = ["one", "two", "three"];
```
### 狭義のオブジェクト型
```typescript
const red: { rgb: string, opacity: number } = { rgb: 'ff0000', opacity: 1 };
```
### インターフェース
```typescript
interface Color {
    readonly rgb: string;
    opacity: number;
    name?: string;
}
```
* `readonly`: 書き換え不可のプロパティ。
* `プロパティ名末尾の?`: プロパティは省略可能。
### enum
```typescript
enum Pet {
    Cat = "Cat",
    Dog = "Dog",
    Rabbit = "Rabbit",
}

let Tom: Pet = Pet.Cat;
```
### リテラル型
* ユニオン型と組み合わせることで、enum型のような表現が可能。
```typescript
let Mary: 'Cat' | 'Dog' | 'Rabbit' = 'Cat';
```
### タプル型
```typescript
const charAttrs: [number, string, boolean] = [1, 'patty', true];
```
### any型
* どんな型でも受け付ける。
* JSONファイルのパースなど事前に型が分からないが、そのまま処理をする必要がある場合に利用する。
* 型安全ではない。
### unknown型
### never型
* case文の漏れをチェック。
```typescript
const greet = (friend: 'Several' | 'Caracal' | 'Cheetah') => {
    switch (friend) {
        case "Caracal":
            return `Hello, ${friend}!`;
        case "Cheetah":
            return `Hello, ${friend}!`;
        case "Several":
            return `Hello, ${friend}!`;
        default:
            const check: never = friend;
    }
}
```



## クラス、型
```typescript
class Rectangle {
    readonly name = 'rectangle';
    sideA: number;
    sideB: number;

    constructor(sideA: number, sideB: number) {
        this.sideA = sideA;
        this.sideB = sideB;
    }
    
    getArea = (): number => this.sideA * this.sideB;
}
```
### 合成
#### 継承の問題点
* 継承では子クラスが親クラスに強く依存してしまう。
  * 親クラスの変更が子クラスに影響を及ぼす。
  * 不必要なメンバー変数やメソッドなども継承してしまう。
  * テストを書いても子クラスのそれでは、漏れが発生してしまう。
  * 親・子クラス間で名前空間を共有しているため、責任の境界線が曖昧。それにより設計が難しくなる。
  * 親・子クラス間で名前空間を共有しているため、不具合の調査難易度が上がる。
  * 抽象クラスは定義に実装を含めることができてしまう。
    * 実装を伴った継承は避けたい。
    * インターフェースを使うことで、型を定義する。
  
* 上記のような問題に対処していくためには、独立性を高めた部品の組み合わせでソースを組んでいく必要がある。

合成によるコーディング例
```typescript
class Rectangle {
    readonly name = 'rectangle';
    sideA: number;
    sideB: number;

    constructor(sideA: number, sideB: number) {
        this.sideA = sideA;
        this.sideB = sideB;
    }

    getArea = (): number => this.sideA * this.sideB;
}

class Square {
    readonly name = 'square';
    side: number;

    constructor(side: number) {
        this.side = side;
    }
    
    getArea = ():number => new Rectangle(this.side, this.side).getArea();
}
```
インターフェースで型を定義。
```typescript
interface Shape {
  readonly name: string;
  getArea: () => number;
}

interface Quadragle {
  side: number;
}

class Rectangle implements Shape, Quadragle {
  readonly name = 'rectangle';
  side: number;
  sideB: number;

  constructor(side: number, sideB: number) {
      this.side = side;
      this.sideB = sideB;
  }
  
  getArea = (): number => this.side * this.sideB;
}
``` 
* TypeScriptでクラスを定義すると、クラスインスタンスのインターフェース型宣言、コンストラクタ関数の2つが同時に宣言される。
  * 型のコンテキストではインターフェース、通常のコンテキストではコンストラクタ関数として扱われる。
  
## 型エイリアス
```typescript
type Unit = 'USD' | 'EUR' | 'JPY' | 'GBP';

type TCurrency = {
    unit: Unit;
    amount: number;
}

const prive: TCurrency = { unit: 'JPY', amount: 1000 };
```
## インターフェース
```typescript
type Unit = 'USD' | 'EUR' | 'JPY' | 'GBP';

interface Icurrency {
    unit: Unit;
    amount: number;
}

const prive: ICurrency = { unit: 'JPY', amount: 1000 };
```
* インターフェイスは`拡張に対してオープン`な性質がある。
  * 以下例のように、プロパティの定義が追加されていく。
  * どこでも追加できてしまうので、メンテナンス性に乏しく、バグに繋がりやすい。
  * 型エイリアスの方が良さそう。
```typescript
interface User {
    name: string;
}

interface User {
    age: number;
}

interface User {
    species: 'rabbit' | 'bear' | 'fox' | 'dog';
}

const rolley: User = { name: 'Rolley Cocker', age: 8,  species: 'dog' };
```
## ユニオン型
* `|`で型を並べて定義。
* 既存の型を組み合わせて、複雑な型を表現できる。
  * 定義に並べられた型のいずれかが適用される。
```typescript
type A = {
    foo: number;
    bar?: string;
}

type B = { foo: string };

type AorB = A | B;
```
## インターセクション型
* `&`で型を並べて定義。
* 内部のプロパティがマージされるイメージ。
```typescript
type A = { foo: number };
type B = { bar: string };

type AnB = A & B;
```
* インターフェースの拡張をインターセクション型で行う。
```typescript
type Unit = 'USD' | 'EUR' | 'JPY' |  'GBP';
interface Currency {
    unit: Unit;
    amount: number;
}

interface IPayment extends Currency {
    date: Date;
}

type IPayment = Currency & {
    date: Date;
};

const date = new Date('2020-09-01T12:00+0900');
const payA: IPayment = { unit: 'JPY', amount: 10000, date };
const payB: TPayment = { unit: 'USD', amount: 100, date };
```
## 型の演算子
### typeof
* 値の型の名前を文字列にして取り出す。
* 型推論で既存の変数から型を抜き出して使いまわせる。
```typescript
console.log(typeof 100)  // 'number'

const arr = [1, 2, 3];
type NumArr = typeof arr;
const val: NumArr = [4, 5, 6];
```
### keyof
* 既存のオブジェクトから型を抽出できる。
```typescript
const permissions = { 
    r: 0b100 as const, w: 0b010 as const, x: 0b001 as const,
};
type PermsChar = keyof typeof permissions;  // 'r' | 'w' | 'x'
typePermsNum=typeofpermissions[PermsChar];  //1|2|4
```
### その他ユーティリティ
* `Partial<T>`
  * Tのプロパティを全て省略可能にする。
* `Required<T>`
  * Tのプロパティを全て必須にする。
* `Readonly<T>`
  * Tのプロパティを全て読み取り専用にする。
* `Pick<T, K>`
  * TからKが指定するキーのプロパティだけを抜き出す。
  ```typescript
  type PickedTodo = Pick<Todo, 'title' | 'isDone'>;  // titleとisDoneを抜き出したオブジェクトが返る
  ```
* `Ommit<T, K>`
  * TからKが指定するキーのプロパティを省く。
* `Extract<T, U>`
  * TからUの要素だけを抜き出す。
* `Exclude<T, U>`
  * TからUの要素を省く。
* `NonNullable<T>`
  * Tからnullとundefinedを省く。
* `Parameters<T>`
  * Tの引数の型を抽出し、タプル型で返す。
* `ReturnType<T>`
  * Tの戻り値の型を返る。
### 型アサーション
### 型ガード
プリミティブ型向け
```typescript
const foo: unknown = '1,2,3,4';

if (typeof foo === 'string') {
    console.log(foo.split(','));
}
```
クラスのインスタンス向け
```typescript
class Base { common = 'common'; }
class Foo extends Base { foo = () => { console.log('foo'); }}
class Bar extends Base { bar = () => { console.log('bar'); }}

const doDivide = (arg: Foo | Bar) => {
    if (arg instanceof Foo) {
        arg.foo();
    } else {
        arg.bar();
    }
}
```
### 型術後

## 関数
### オーバーロード



# JSX
## サンプルコード例
### main的な部分
```typescript
import React from 'react';
import Greets from './components/Greets';
import SummaryText from './components/SummaryText';
import TextInput from './components/TextInput';
import './App.css';

const App: React.FunctionComponent = () => (
  <div className="App">
    <Greets name="Patty" times={4}>
      <span role="img" aria-label="rabbit">🐰</span>
    </Greets>
    <SummaryText>
      &lt;Summary&gt;<br />
      Patty Hope-rabbit, along with her family, arrives in Maple Town,
      a small town inhabited by friendly animals.

      Soon, the Rabbit Family settles in Maple Town as mail carriers and the bitter,
      yet sweet friendship of Patty and Bobby begins to blossom.
    </SummaryText>
    <TextInput />
  </div>
);

export default App;
```
* 各コンポーネントをimport。
```typescript
import React from 'react';

type Props = { name: string; times?: number };

const Greets: React.FunctionComponent<Props> = (props) => {
  const { name, times = 1, children } = props;

  return (
    <>
      {[...Array(times)].map((_) => (
        <p>Hello, {name}! {children}</p>
      ))}
    </>
  );
};

export default Greets;
```
* childrenにはAppのspanが入ってくる。
* returnで返されるJSXが最終的にはレンダリングを経てHTMLへ。
```typescript
import React from 'react';

const TextInput: React.FunctionComponent = () => {
  const inputRef = React.useRef<HTMLInputElement>(null);

  const handleClick = (): void => {
    console.log(inputRef.current);
    if (inputRef.current) inputRef.current.focus();
  };

  return (
    <div>
      <input type="text" ref={inputRef} />
      <input type="button" value="Focus" onClick={handleClick}/>
    </div>
  );
};

export default TextInput;
```