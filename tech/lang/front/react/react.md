# React

# Presentational Component / Container Component
* フロントエンドを構築する際のデザインパターン。「見た目」と「機能」を分割する。
* `Presentational Component`
  * 見た目だけを責務とするコンポーネント。
* `Container Component`
  * 機能を責務とするコンポーネント。

# State Hooks
* アプリの「状態」をどう扱うか考える上で選択肢の一つ。
## 実装例
```typescript
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
# Effect Hooks
* 副作用を扱う為のAPI。
* 副作用の具体例
  * データの取得
  * リアクティブな講読
  * ログの記録
  * リアルDOMの手動書き換え
## 実装例
```typescript
const SampleComponent: FC = () => {
    const [date, setDate] = useState();
    
    useEffect(() => {
        doSomething();
        return () => clearSomething();
    }, [someDeps]);
};
```
* `useState()`
* `someDeps`
  * 依存配列。
  * レンダリング時と比較して、依存配列内の要素に差分があれば、第一引数の関数が実行される。

## 後で整理する
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
## 