# Ruby

# 環境構築
## rbenv
* rbenvのインストール。
```bash
brew install rbenv
```
* インストールできるrubyのバージョンを確認。
```bash
rbenv install --list
```
* rubyをrbenv経由でインストールする。
```bash
rbenv install <バージョン>
```



# 変数
## 多重代入
```bash
a, b, c = 1, 2, 3
```
* 配列 + 多重代入
```ruby
a, b, c = [1, 2, 3]
```
* 1つの変数に複数の値を代入する。
```bash
irb(main):108:0> a = 1,2
=> [1, 2]
irb(main):109:0> a
=> [1, 2]
```
* 余った値を無視しないで代入(可変調引数)する。
```bash
irb(main):114:0> a, *b = 1, 2, 3
=> [1, 2, 3]
irb(main):115:0> a
=> 1
irb(main):116:0> b
=> [2, 3]
```



# 条件式
## if
```ruby
if <条件式> then
end
```
* if式は文ではなく式。
  * つまり値を返すので、変数とかにも条件分岐付きで書ける。
```ruby
a = if true
  1
end
```
```ruby
a = if false then
  1
elsif false
  2
else
  3
end
```
* if修飾子
  * 変数に値が入るか入らないかに関わらず、領域は確保(=定義)される。
```ruby
a = 1 if true
b = 2 if false
```
* 三項演算子
```ruby
a = true ? 1 : 2
```
## 擬似変数
* `nil`
  * 他の言語で言うところの`null`に相当する。
  * falsy的な意味合いを持つ。
## case式
* 各条件式で指定された`===`演算子が、caseで指定された値を引数として実行される。
```ruby
case <式>
when <条件式1> [then]
when <条件式2> [then]
else
end
```


# 文字列リテラル
## パーセント記法
### ダブルクォート文字列
* 文字列を囲む記号を書いてる人が指定できる。
* 数値、アルファベット以外の文字が使用できる。
```ruby
a = %*test*
```
### 式展開
* `%q`、`%Q`で式展開する・しないを指定できる。
  * `%q` 式展開しない。
  * `%Q` 式展開する。
```ruby
a = 1
%q!#{a + 1}!
%Q!#{a + 1}!
```


# 文字列
## 結合
* `+`、`<<`で連結できる。
```ruby
a = "ru"
p a << "by"
```
## 比較
* 辞書順比較を搭載。
```ruby
"a" < "b"
"ab" < "ac"
```
## フォーマット指定
* `sprintf`でフォーマットを指定できる。



# シンボル
* シンボルは「文字の並び」が同じであれば、同一のオブジェクトを参照する。
  * 文字列は文字の並びが同じでも、オブジェクトを作る度に異なるオブジェクトが生成されるので「同じ」ではない。
  * オブジェクトが同一、とは`オブジェクトID`が同じということ。
```ruby
# オブジェクトIDの確認
p "foo".object_id
```
* `equal?`でオブジェクトが同一かを判定。
```ruby
"foo1".equal? "foo1"
```
* `==`でオブジェクトの「値」が等しいかを判定。
```ruby
"foo1" == "foo1" #=> true
```
* `eql?`は「値」と「型」の比較を行う。
```bash
irb(main):028:0> (1.0).eql? 1
=> false
```
* シンボルは同じ(同一)なオブジェクトになる。
```bash
irb(main):059:0> v1 = "foo"
=> "foo"
irb(main):060:0> v2 = "foo"
=> "foo"
irb(main):061:0> p v1.object_id
70121657842780
=> 70121657842780
irb(main):062:0> p v2.object_id
70121657836800
=> 70121657836800
irb(main):063:0> v1 = :foo
=> :foo
irb(main):064:0> v2 = :foo
=> :foo
irb(main):065:0> p v1.object_id
1518748
=> 1518748
irb(main):066:0> p v2.object_id
1518748
=> 1518748
```



# 関数
* 引数を渡した場合、引数にコピーされる。
* 引数に対して破壊的変更を加える場合、関数名に`!`を付与する。
```ruby
def func v1
  v1 += "foo2"
end
```
* 多値を返却する。
```ruby
def foo
  return 1, 2, 3
end
```
* 可変調引数を使った関数定義。
```ruby
# 関数定義における可変調引数
def foo(a, *b)
  b
end
```



# 配列
* 要素が全て文字列で良いなら、`%w`、`%W`を使って以下のような定義も可能。
  * `%w` シングルクォート文字列
  * `%W` ダブルクォート文字列
* 個人的には読みづらい。
```bash
irb(main):068:0> v1 = %w(hoge foo bar)
=> ["hoge", "foo", "bar"]
```
* 要素、大きさを指定した定義方法。
```bash
irb(main):070:0> a = Array.new(5)
=> [nil, nil, nil, nil, nil]

irb(main):071:0> a = Array.new(2, "a")
=> ["a", "a"]  # 全ての要素は同じオブジェクトを参照する点に注意。

irb(main):072:0> Array.new(2){"a"}
=> ["a", "a"]  # 全ての要素を「別個」に扱いたい場合はこっちの書き方。
```
* 配列の長さは自動で調整される。
```bash
irb(main):086:0> v1 = [10]
=> [10]
irb(main):087:0> v1.length
=> 1
irb(main):088:0> v1[3] = 100
=> 100
irb(main):089:0> v1.length
=> 4
irb(main):090:0> v1[2]
=> nil
```
* 配列のインデックスに`-1`を指定すれば末尾の様子を取得できる。
```bash
irb(main):092:0> v1
=> [10, nil, nil, 100]
irb(main):093:0> v1[-1]
=> 100
```
* 配列の要素を範囲指定で取得する。
```bash
irb(main):098:0> v1
=> [10, nil, nil, 100]
irb(main):099:0> v1[0, 3]  # 最初の要素から3要素を切り出す
=> [10, nil, nil]
```
* 配列の範囲を指定して、1つの要素に置き換える。
  * 指定した範囲の要素をそれぞれ置き換えるわけではない点に注意する。
```bash
irb(main):103:0> v1 = [1,2,3,4,5,6,7,8,9]
=> [1, 2, 3, 4, 5, 6, 7, 8, 9]
irb(main):104:0> v1[1, 3] = "a"
=> "a"
irb(main):105:0> v1
=> [1, "a", 5, 6, 7, 8, 9]
```
* イテレーション。
  * for式はスコープを持たないため、式の中で初期化された変数はその後参照可能になる。
  * `each`はスコープを生成するので、必要に応じて使い分ける。
```bash
# for
irb(main):120:0> for i in arr do
irb(main):121:1* p i
irb(main):122:1> end
1
2
3
=> [1, 2, 3]

# each
irb(main):152:0> [1, 2, 3].each do |i|
irb(main):153:1* p i
irb(main):154:1> end
1
2
3
=> [1, 2, 3]
```



# ハッシュ
* 定義方法。
```bash
irb(main):155:0> h = {"foo1" => 1, "foo2" => 2}
=> {"foo1"=>1, "foo2"=>2}
irb(main):156:0> h["foo1"]
=> 1
```
* ハッシュのキーにはシンボルも指定可能。
```bash
irb(main):166:0> a = {:foo1 => 1, :foo2 => 2}
=> {:foo1=>1, :foo2=>2}
irb(main):167:0> a[:foo1]
=> 1
```



# 範囲
* `..`とか`...`でRangeクラスのインスタンスを作成できる。
  * `..` 1から10以下の範囲。
  * `...` 1から10未満の範囲。
  * `"a" .. "z"` aからz以下の範囲。
* 範囲オブジェクトにおける演算子。
  * オブジェクト毎に演算子の意味合いが色々ある点は改めて認識しておくと良さそう。
  * `==` 同値判定。
  * `===` 包含判定。
* `for式`+範囲オブジェクト。
```bash
for i in "a".."z"
  p i
end
```
* 範囲オブジェクトを配列や文字列のインデックスとして使用する。
```bash
a = [1, 2, 3, 4, 5]
p a[2..3]
#=> [3, 4]

a = "abcdefg"
p a[2..3]
#=> "cd"
```



# ループ
* 繰り返し処理の書き方。
```ruby
while <条件式> do
end
```
```ruby
i = 0
while (0..4) === i do
  p i
  i += 1
end

# iが5になるまでループ
until i == 5 do
  i += 1
end
```
## 脱出構文
* `break` ループそのものを中断する。
* `next` 現在の処理を直ちにスキップする。他の言語でいうところのcontinueに相当する。
* `redo` 現在の処理をやり直す。
```ruby
# reduを使った無限ループ
10.times do |i|
  # i == 5のタイミングでループ処理そのものをやり直す。
  redo if i == 5
end
```



# 正規表現
* 正規表現オブジェクトの生成。
  * `/`で囲むと正規表現が生成される。
  * %記法で書く場合は`%r`で正規表現オブジェクトが生成される。
* `=~`演算子 マッチした文字列のインデックスを取得する。マッチしない場合はnilを返す。
```bash
/Ruby/ =~ "I love Ruby"
#=> 7
```
* `$&` `=~`でマッチした文字列を取得する。
```ruby
/Ruby/ =~ "I love Ruby"
p $&
#=> "Ruby"
```
* `$` `=~`でマッチした箇所以外の文字列を取得する。
```ruby
/Ruby/ =~ "I love Ruby"
p $`
#=> "I love "
```
* `$'` `=~`でマッチした文字より後の文字列を参照する。
* パターンの`or`条件。
```ruby
exp = /^(aa|bb)c$/
p exp === "aac"
#=> true
```
* 要素の`or`条件。
```ruby
exp = /a[bcd]e[fg]h/
p exp === "abegh"
#=> true
```
* 連続する要素を指定。
```ruby
p /a[1-5]z/ === "a2z"
#=> true

p /a[b-d]z/ === "abz"
#=> true
```
* 文字列の繰り返し。
  * bcの0回以上の繰り返しを検知。
```ruby
p /a(bc)*d/ === "abcbcd"
#=> true
```
* 文字列が数字。
```ruby
p /\d/ === "1"
#=> true
```



# ブロック・Proc・lambda
* クロージャ
```ruby
def func y
  y + yield
end

x = 2

p func(1) { x += 2 }
```
* Procオブジェクト → ブロックオブジェクトの変換
  * Procオブジェクトに`&`を付与、最後の引数として渡す。
  * その結果、yield部分がブロックオブジェクトとして置き換えられる。
```ruby
def func x
  x + yield
end

proc = Proc.new {2}
func(1, &proc)
```
* ブロックオブジェクト → Procオブジェクトの変換
  * ブロックオブジェクトに`&`を付与、最後の引数として渡す。
  * その結果、引数に対して`call`を呼び出すことでProcオブジェクトを実行できる。
```ruby
def func x, &proc
  x + proc.call
end

func(1) do
  2
end
```
* lambdaメソッド
  * lambdaメソッドはProcインスタンスを生成するが、違いがある(後述)。
```ruby
lmd = lambda{ |x| p x }
# 1.9以降
lmd = -> (x) { p x }
lmd.call(1)
```
* Procとlambdaの違い
  * proc中のreturnでは、生成元のスコープを脱出する。
  * lambda中のreturnでは、呼び出し元に復帰する。
  * トップレベルで生成したproc内部でリターンするとエラーが起きることに注意する。
```ruby
# proc中のリターン
def func
  proc = Proc.new{ return 1 }
  proc.call
  2 # 実行されない
end

p func
```
```ruby
# lambda中のリターン
def func2
  proc = lambda{ return 1 }
  proc.call
  2 # 実行される
end

p func2
```



# スレッド
* `Thred`クラスをインスタンス化すると、新しいスレッドを生成することができる。
  * `new`、`start`、`fork`でスレッド生成できる。
* Thredクラスの`join`メソッドでスレッドの終了を待つことができる。



# 例外処理
* 例外が発生する可能性のある部分を`begin, end`で囲む。
  * pythonのtry, catchに該当。
* その中の`rescue`節で例外発生時の処理を記述する。
* その中の`else`節でresucure節が`実行されなかったとき`の処理を書く。
* `ensure`節 rescue節に続けて記述可能。`最後に必ず実行したい`処理を書く。
  * pythonのfinallyに該当。



# Tips
## イテレーション系
### 配列each
* for式、while式はスコープが作成されないので、イテレーション系の処理ではeachとかを使うらしい。
```ruby
[1, 2, 3].each do |value|
  p value
end
```
### 配列each + インデックス
```ruby
[3, 4, 5].each_with_index do |value, index|
  p value + index
end
```
### ハッシュeach
```ruby
# key & value
{:a => 1, :b => 2}.each do |key, value|
  p "#{key}:#{value}"
end

# key only
{:a => 1, :b => 2}.each_key do |key|
  p "#{key}"
end

# value only
{:a => 1, :b => 2}.each_value do |value|
  p "#{value}"
end
```
### Range each
```ruby
("a".."z").each do |value|
  p value
end

2.upto(4) do |i|
  p i
end

5.downto(1) do |i|
  p i
end

4.times do |i|
  p i
end
```

### zip
```bash
# pythonでいうzipみたいな動き。
irb(main):144:0> v1.zip(v2) do |i, j|
irb(main):145:1* p i
irb(main):146:1> p j
irb(main):147:1> end
1
4
2
5
3
6
=> nil
```
## コマンド出力
* 「`」で囲まれた文字列はコマンドとして解釈される。OSに渡されて実行され、その結果が文字列で返却される。
```ruby
puts `ls -a`

#=> .
#=> ..
#=> main.rb
```