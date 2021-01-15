# React

# Presentational Component / Container Component
* フロントエンドを構築する際のデザインパターン。「見た目」と「機能」を分割する。
* `Presentational Component`
  * 見た目だけを責務とするコンポーネント。
* `Container Component`
  * 機能を責務とするコンポーネント。



# props
* コンポーネントを関数とみた時の引数にあたる。
* 暗黙のpropsとして子要素が渡される。
* propsの渡し方
  * コンポーネントが関数の場合はその関数の第一引数としてpropsが渡される。
  * コンポーネントがクラスの場合は初期化時にメンバーオブジェクトpropsとして渡される。
### 実装例
* CharacterListにcharactersを渡す例。
```typescript
return (
      <div className="container">
        <header>
          <h1>『SLAM DUNK』登場人物</h1>
        </header>
        <CharacterList school="湘北高校" characters={characters} />
      </div>
  );
```



# State Hooks
* アプリの「状態」をどう扱うか考える上で選択肢の一つ。
## 実装例
```typescript
type State = { 
    count: number;
};

const Counter: FC = () => {
    const [count, setCount] = useState(0);
    const reset = () => setCount(0);
    const increment = () => setCount((c) => c + 1);

    return (
        <Card>
            <Statistic className="number-board">
                <Statistic.Label>count</Statistic.Label>
                <Statistic.Value>{count}</Statistic.Value>
            </Statistic>
            <Card.Content>
                <div className="ui two buttons">
                    <Button color="red" onClick={reset}>
                        Reset
                    </Button>
                    <Button color="green" onClick={increment}>
                        +1
                    </Button>
                </div>
            </Card.Content>
        </Card>
    );
};
```
* `useState()`
  * 変数とその変数のsetterを返す。useStateを経由して「状態」変数を扱う。
  * useStateに引数を渡すと、それが初期値になる。
  * 必ず関数コンポーネントのトップレベルで呼び出すこと。
* 例えば外部APIの返却値を取得して、stateに入れようとすると、事前に型が分からないので初期値を指定できない。  
  `useState()`に型引数を渡す事で型推論をパスする。



# Effect Hooks
* Effect HookはState Hookと一緒に扱われることが多い。
* 副作用を扱う為のAPI。
* 副作用の具体例
  * データの取得
  * リアクティブな講読
  * ログの記録
  * リアルDOMの手動書き換え
  
## useEffect
### 実装例
```typescript
const SampleComponent: FC = () => {
    const [date, setDate] = useState();
    
    useEffect(() => {
        doSomething();
        return () => clearSomething();
    }, [someDeps]);
};
```
* `useEffect()`
  * 第一引数に引数を取らない関数を指定する。
  * 第一引数：コンポーネントがアンマウントされる時に戻り値の関数を実行してくれる。
  * 第二引数
    * `someDeps`
      * 依存配列。
      * レンダリング時と比較して、依存配列内の要素に差分があれば、第一引数の関数が実行される。
      * 依存配列に空配列を渡す → `componentDidMount`
      * 依存配列に空配列を渡さない → `componentDidUpdate`
  * 上記`doSomething()`でstate変数を書き換えたりする。
  * useEffectの初回実行は最初のレンダリングが行われ、ブラウザに反映された直後。  
    その後、副作用が反映された内容で再度レンダリングされる。
    * ロード中のプレースホルダーを表示するなど。
## Effect Hooksとライフルサイクルの相違点
1. 実行タイミング
   * `useEffect`と`componentDidMount`
     * `componentDidMount`
       * 仮想DOMがリアルDOMへ反映される前に、ブラウザへの表示をブロックして実行される。この処理が終わるまでブラウザには何も表示されない。
     * `useLayoutEffect`
       * Effect Hooksでは`componentDidMount`や`componentDidUpdate`と同じ動きをするのが`useLayoutEffect`。
## useMemo
* 関数コンポーネントの中で、計算リソースを多く消費する処理がある際にはメモ化して保存しておく事で2回目以降の処理速度を最適化できる。

実装例
```typescript
const Timer: FC<{ limit: number }> = ({ limit }) => {
    const [timeLeft, setTimeLeft] = useState(limit);
    const prime = useMemo(() => getPrimes(limit), [limit]);
};
```
* `useMemo()`
  * 計算結果をコンポーネントの外に保存しておく。
  
## useCallback
* メモ化したコールバックを返却する。
* 関数そのものをメモ化するのに使用される。

```typescript
const memoizedCallback = useCallback(
        () => {
            doSomething(a, b);
        },
        [a, b],
);
```
* 依存配列`[a, b]`の内容が書き換わる度にuseCallbackの第一引数が再定義される。
* 下記処理は等価
```typescript
useCallback(fn, deps)
```
```typescript
useMemo(() => fn, deps)
```


## useRef
* リアルDOMへの参照に使う。
```typescript
const TextInput: FC = () => {
    const inputRef = useRef<HTMLInputElement>();
    
    return (
        <>
                <input ref={inputRef} type="text">
        </>
    );
}
```
* 上記例の様に、useRefで生成したオブジェクトをJSX内でrefに渡す事で、`inputRef.current`から参照できるようになる。


# 後で整理する
* `public/index.html`の`<div id="root"></div>`の中身が、`src/index.tsx`の`RenderDOM.render()`の第二引数`document.getElementById('root')`に紐づく。
  * `RenderDOM.render()`の第一引数はJSXというもの。
* `public/index.html`と`src/index.tsx`は、Babelでコンパイル→webpackでまとめられた結果、`/static/js/main.chunk.js`の中で紐づけられている。



# cheet sheet
## 関数コンポーネント
```typescript
import React, {FC} from 'react';

const FunctionName: FC = () => {
};
```
## 関数コンポーネント + state
* 関数コンポーネントへ引数を渡す。
```typescript
import React, {FC} from 'react';

// JSでは型が分からない場合がある
// モデルクラス的な感じで型を一緒に定義
type Props = {
    school: string;
    characters: Character[];
};

// 引数propsとしてJSXのタグに記述した内容が渡される
const CharacterList: FC<Props> = (props) => {
    // 引数propsをローカル変数に分割代入
    const { school, characters } = props;
};
```
## クラスコンポーネント(Componentを使った実装)
* 第一引数はprops
  * 不要な場合はunknownで設定する。
* 第二引数はstate型を指定。
  * 「状態」をコンポーネント間でやりとりする例の１つ。
```typescript
class App extends Component<unknown, State> {
}
```
## コンポーネント + ライフサイクル
### componentDidMount
* コンポーネントがマウントされた直後に呼ばれるメソッド。
* `コンポーネントがマウントされる`とは、

## イベント発火
* コンポーネント内関数 + onClickで実現できる
```typescript
const clicekEvent = () => {};

...

return (
    <>
            <input onCLick={clickEvent}>
    </>
            
);
```


# Linter
* react-hooks/rules-of-hooks
* eslint-plugin-react-hooks/exhaustive-deps
  * useMemo, useCallbackに渡される依存配列が正しいかをチェックしてくれる。