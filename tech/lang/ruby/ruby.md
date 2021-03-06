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


# 数値
## 数値リテラル
* 数値リテラルの中には`_`を入れることができる。
```ruby
p 100_000
```  
* 2進数(binary)
```ruby
p 0b01  # => 1
p 0b11  # => 3
```
* 8進数(octal)
```ruby
p 0o7   # => 7
p 0o10  # => 8
```
## UFO演算子
* 左辺の値が右辺の値より大きければ1、等しければ0、小さければ-1を返却する。
```ruby
100 <=> 10   #=> 1
10 <==> 100  #=> -1
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
* whenの条件式には複数の条件式を指定することもできる。
```ruby
```


# 文字列
## パーセント記法
### ダブルクォート文字列
* 文字列を囲む記号を書いてる人が指定できる。
* 数値、アルファベット以外の文字が使用できる。
```ruby
a = %*test*
```
### 式展開
* シングルクォートで囲む。
  * 式展開ができない。
* ダブルクォートで囲む。  
  * 式展開ができる。
```ruby
a = 100
p 'a is #{a}'  # => "a is \#{a}"
p "a is #{a}"  $ => "a is 100"
```  
* `%q`、`%Q`で式展開する・しないを指定できる。
  * `%q` 式展開しない。
  * `%Q` 式展開する。
```ruby
a = 1
%q!#{a + 1}!
%Q!#{a + 1}!
```
## 文字列 → ? の変換
* `to_i`
  * 数値へ変換。
  * 123abd45のような文字列が変換対象の場合、左から数値として有効な部分のみ切り出して評価する。
    * 上記例の場合、返却されるのは123。

## 文字列オブジェクト
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
## p, puts, print
* `p`はデバッグ用に内部構造を出力する。
  * バックスラッシュ記法で標準出力される。
* `puts`や`print`は実際に目に見える形で出力する。
  * バックスラッシュ記法を「解釈」した形で出力する。
```ruby
p "this is\na test"
# => "this is\na test"

puts "this is\na test"
print "this is\na test"
# => this is
# => a test
```  
## ヒアドキュメント
* バックスラッシュ記法による表現は可読性が悪い。
* ヒアドキュメントとはバックスラッシュ記法を使わないで、可読性良く表現する記法。
* `注意1` ヒアドキュメントの終端を示す識別子の前にはスペースなどの文字を記述してはならない。
```ruby
query = <<SQL
  select *
    from table;
SQL

p query
# => "  select *\n    from table;\n"

print query
# =>   select *
# =>    from table;
```
* ヒアドキュメントの識別子をシングルクォートで囲む。
  * 式展開ができない。
* ヒアドキュメントの識別子をダブルクォートで囲む。  
  * 式展開ができる。
  
# シンボル
* シンボルは「文字の並び」が同じであれば、同一のオブジェクトを参照する。
  * 文字列は文字の並びが同じでも、オブジェクトを作る度に異なるオブジェクトが生成されるので「同じ」ではない。
  * オブジェクトが同一、とは`オブジェクトID`が同じということ。
* 実態は`Symbol`オブジェクト。
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
* キーワード引数
```ruby
def test(a:, b:)
  a + b
end


# p test(100, 100)  # Wront number of Arguments
p test(a: 100, b: 100)
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
* 定義方法によっては初期化時に格納される要素が同一オブジェクトになる。
  * (1)の定義方法。別々のオブジェクトとして初期化したい場合は(2)の定義方法を使う。
```bash
irb(main):070:0> a = Array.new(5)
=> [nil, nil, nil, nil, nil]

# (1)
irb(main):071:0> a = Array.new(2, "a")
=> ["a", "a"]  # 全ての要素は同じオブジェクトを参照する点に注意。

# (2)
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
* Ruby1.9からは以下のように`:`で区切る定義方法も可能。
  * この方法で定義するとキーはシンボルとなる。
```ruby
a = { foo1: 1, foo2: 2, foo3: 3 }
```
* `Array#to_h`を使って二次元配列からハッシュを作成する方法もある。
```ruby
arr = [[:foo, 1], [:bar, 2]]
hash = arr.to_h
p hash  # => {:foo=>1, :bar=>2}
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
* `=~`演算子を使用するよりも、`match`を使用する方が良さそう。
  * `=~`を使用すると特殊グローバル変数として追加されてしまう。
* `$*`系の特殊変数はワンライナーなどで使用するべき。普通に読みづらい。



# ブロック・Proc・lambda
* クロージャ
```ruby
def func y
  y + yield
end

x = 2

p func(1) { x += 2 }
```
* `next` Procの中で処理を中断して、呼び出し元に戻る。
```ruby
f = Proc.new {
  next "next"  # 呼び出し元には"next"が戻る。
}
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
  * lambdaメソッドやprocメソッドで生成した手続きオブジェクトは引数の数が異なるとエラーを出すが、Proc.newで生成した手続きオブジェクトでは引数への多重代入として処理される。
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
* `rescue`節で例外発生時の処理を記述する。
* `else`節でresucure節が`実行されなかったとき`の処理を書く。
* `ensure`節 rescue節に続けて記述可能。`最後に必ず実行したい`処理を書く。
  * pythonのfinallyに該当。
* rescueに続けて指定することで、それ自身orそのサブクラスを捕捉できる。
  * rescue節に続けて書く場合は、マッチする範囲が広くなる順番に指定すること。
```ruby
begin
rescue ZeroDivisionError => e
  p e.backtrave
end
```
* 同じスレッド・ブロックで発生した最後の例外は`$!`で参照できる。
* `raise`メソッドを引数なしで実行すると、最後に発生した例外を再度発生させられる。
```ruby
begin
  1/0
  rescue ZeroDivisionError
    p $!.class
    raise
end
```
* `retry`を呼び出すと、再度rescue節を呼び出すことができる。
  * 例外が起きた該当箇所で処理を復旧させたい場合に使える。
* `catch/throw`を使うことで正常時にも処理をジャンプできる。
  * goto文みたいな感じ？
```ruby
def foo
  throw :exit
end

catch(:exit) {
  foo
  p 1  # 実行されない
}

p 2
#=> 2
```



# オブジェクト指向関連
## クラス定義
* `@変数名` インスタンス変数。
* `new`メソッド インスタンスを生成。
```ruby
class Foo
  def initialize(a)
    @a = a
  end

  def method1
    @a
  end
end

a.new(1)
```
## 継承
* `<`で区切ってクラスオブジェクトを指定することで継承ができる。
* `super`をカッコと引数を付けずに実行すると、そのままスーパークラスの同盟メソッドに渡して実行する。
```ruby
class Foo
  def initialize(a)
    @a = a
  end

  def method1
    @a
  end
end

class FooExt < Foo
  def initialize(a, b)
    @b = b
    super a
  end

  def method2(c)
    @a + @b + c
  end
end

fooExt = FooExt.new(3, 4)
p fooExt.method1
p fooExt.method2(5)
```
* スーパークラスの取得。
```ruby
FooExt.superclass == Foo
#=> true
```
## メソッドの探索経路
* インスタンスのメソッドを呼び出して、それがクラスに存在しない場合は、継承元を`右方向`に辿る。
* 継承関係を省略してクラスを定義すると、自動的に`Object`クラス(Ruby1.9以降では`BasicObject`クラス)を継承する事になる。
* クラスの継承チェーンを参照する。`ancestors`の実行結果は検索順序と同じ順番で返却される。
```ruby
# class Fooの定義は省略
p Foo.ancestors
#=> [Foo, Object, Kernel, BasicObject]
```
* クラスの包含関係。
```ruby
# class Fooの定義は省略
p Foo < Object
#=> true
```
* オブジェクトが持つインスタンスメソッドを調べる。
```ruby
# falseを指定すると、スーパークラスを辿らない
p Foo.instance_methods(false)
```
* オブジェクトが持つインスタンス変数を調べる。
```ruby
<オブジェクトインスタンス>.instance_variables
```
* `alias` メソッドの別名を付ける。
```ruby
alias <新メソッド名> <旧メソッド名>
```
* `undef` 指定された定義を取り消す。
```ruby
undef <メソッド名>, ...
```
* `method_missing`をオーバーライドすることで、メソッドが見つからない時の動作をフックできる。
## オープンクラス
* 定義済みのクラスを再定義できる仕組み。
* 以下の例は標準クラスのStringにメソッドをオープンクラスで再定義している。
```ruby
class String
  def huga; 1; end
end
```
## Mix-in
## モジュール
* 定義方法。
```ruby
module Bar
  def methodA
    @a
  end
end
```
* モジュールは単独ではインスタンス化(new)できない。
* モジュールは継承できない。
* モジュールはクラスや他のモジュールに取り込むことができる。
  1. includeが実行される。
  2. 指定されたモジュールに対応する無名クラスを生成。
  3. (2)をスーパークラスとの「間」に入れ込む。
    * ancestorsやsuperclassで参照不可能。
```ruby
# class Fooの定義は省略
# module Barの定義は省略
class FooExt < Foo
  include Bar
end
```
* includeの順番が後のもののメソッドが優先して実行される。
* クラス毎にまとめて、それをクラスで使いまわして共通化するイメージか。
  * 設計とかどうすれば綺麗にできるんだろうか。
## 特異クラス・特異メソッド
* 指定したインスタンスだけに適用されるクラス。
* シングルトンクラス。
* `特異クラス`
  * `extend`メソッドを通して簡潔に書ける。
```ruby
class << 対象のオブジェクト
end

# Barというモジュールが定義済みの前提。
foo1.extend(Bar)
```
* `prepend` メソッドの探索経路を制御できる。
  * prependしたM1のスーパークラスはC1となる。
  * 既存の処理に、新規で処理を追加で挟み込むことができる。
  * ソースがどんどん複雑化しそう。
    * `Refinements`へ。
```ruby
module M1
  def method1
    super
    puts "m1"
  end
end

class C1
  prepend M1
  def method1
    puts "c1"
  end
end

C1.new.method1

#=> m1
#=> c1
```
* `特異メソッド` インスタンスに直接メソッドを追加する。
```ruby
def オブジェクト名.特異メソッド名
end
```
* `Refinements` 
  * usingされる前に定義済みのbarからのfooの呼び出しは上書きされていない。
```ruby
class C
  def foo
    puts "C#foo"
  end

  def bar
    foo
  end
end

module M
  refine C do
    def foo
      puts "C#foo in M"
    end
  end
end

using M

x = C.new
x.foo
x.bar

#=> C#foo in M
#=> C#foo
```
## self
* クラス内部で使用する場合は、そのメソッドを実行するオブジェクトを保持。
## 変数・定数・メソッドの可視性
### ローカル変数
* 英小文字またはアンダースコアで始まる変数名。
* v1にはクラス内部からアクセスできない。
```ruby
v1 = 1

class Qux1
  p v1
end

#=> undefined local variable or method `v1' for Qux1:Class (NameError)
```
* メソッドにおけるローカル変数の参照。
  * クラス定義、内部メソッドは独立したスコープを持つ。
```ruby
v1 = 1

class Qux2
  v2 = 2
  def method1; v1; end
  def method2; v2; end
end

Qux2.new.method1
#=> NameError
Qux2.new.method2
#=> NameError
```
### グローバル変数
* グローバル変数はプログラムのどこからでもアクセス可能。
* 変数名の頭に`$`をつけて定義する。
```ruby
$v1 = 1

class Qux2
  $v2 = 2
  def method1; p $v1; end
  def method2; p $v2; end
end

Qux2.new.method1
Qux2.new.method2
```
### インスタンス変数
* インスタンス変数は変数名の頭に`@`をつけて定義する。
* 初期化されていない場合は、`nil`を返却する。
  * 初期化するにはアクセッサメソッドを経由してセットする必要がある。
* インスタンス変数はメソッドのように`探索されない`ことに注意する。
  * 継承もされない。
```ruby
@v1 = 1

class Qux3
  @v2 = 2
  def method1; p @v1; end
  def method2; p @v2; end
end

Qux3.new.method1  #=> nil
Qux3.new.method2  #=> nil


class Qux4
  attr_accessor :v3
  def method1; @v3; end
end

qux4 = Qux4.new
qux4.v3 = 3
p qux4.v3  #=> 3
p qux4.method1  #=> 3
```
### クラス変数
* インスタンス間で共有され、自分自身のクラス・サブクラスでも共有される。
* `@@`をつけて定義する。
```ruby
class Qux5
  @@v1 = 1
  def v1; @@v1; end
  def v1=(value); @@v1=value; end
end

class Qux5Ext < Qux5
end

qux5 = Qux5.new
p qux5.v1
qux5Ext = Qux5Ext.new
p qux5Ext.v1
```
### 定数
* 大文字から始まる。
* 再代入すると警告が発生される。
* 定数はメソッド内で定義することができない。
* モジュールやクラスに定義されている定数に対しては`::`を指定してアクセスする。
* `<モジュール>.constants` 外部から参照可能な定数リストを取得。
### public
* publicが指定されていれば、どのインスタンスからも実行できる。
### protected
* 自分自身、またはサブクラスのインスタンスから実行できる。
### private
* レシーバをつけた呼び出しができない。
## メソッドの設定
* `attr_accessor` 読み取り & 書き込みメソッドを定義。
* `attr_reader` 読み込みメソッドを定義。
* `attr_writer` 書き込みメソッドを定義。
### memo
```ruby
# グローバル変数の例
$global_sample01 = 100
$global_sample = 100
p $global_sample01
p $global_sample


# ローカル変数の例
_local_sample01 = 10
local_sample = 10

p _local_sample01
p local_sample


# クラス変数・インスタンス変数の例
class SampleClass
  @@class_variable = "class variable"

  def initialize(var)
    @instance_variable = var
  end

  def class_variable
    @@class_variable
  end

  def print_instance_variable
    p @instance_variable
  end
end

sc1 = SampleClass.new("sc1")
p sc1.class_variable
sc1.print_instance_variable

sc2 = SampleClass.new("sc2")
p sc2.class_variable
sc2.print_instance_variable

# クラス変数のオブジェクトIDは同じ
p sc1.class_variable.object_id
p sc2.class_variable.object_id


# 定数
CONSTANT_VARIABLE = "constant variable"
CONSTANT_VARIABLE = "constant variable 2"
p CONSTANT_VARIABLE
```
* 各変数の種別を構文レベルでサポートすることで、コードを読みながら同時にそのスコープも把握できる。



# Fileの読み書き
* ファイルオープン。
```ruby
File.open('<ファイル名>', '<モード>') { |file| file.write "This is new file." }
```


# Tips
## 配列
### ソート
* 小さい順に並び替える。
```ruby
a = [1, 3, 5, 2, 4, 6]
p a.sort
p a.sort!
```
* 要素をランダムな並びにする。
```ruby
a = [1, 2, 3, 4, 5]
p a.shuffle!
```
## ハッシュ
*  ハッシュの生成。
```ruby
a = {"apple" => "fruit",  "coffee" => "drink"}
```
* イテレーション色々。
```ruby
b = {1 => "a", 2 => "b", 3 => "c", 4 => "d"}
b.each { |key, value| puts "#{key} => #{value}\n" }
b.each_key { |key| puts "#{key}" }
b.each_value { |value| puts "#{value}" }
```
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
### 配列要素で繰り返し
* 配列要素をイテレートしながら無限ループ。
```ruby
[1, 2, 3].cycle{ |n| puts n }
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
### 畳み込み演算系
* `inject`、`reduce`で畳み込み演算を行う。
  * 初期値と自身の要素を順に組み合わせて結果を返す演算。
  * 初期値を引数で設定。
```ruby
p [1, 2, 3, 4].inject(0) {|result, val| result + val ** 2}
```
```ruby
(1..10).each_cons(3) {|item| p item}
```
```ruby
[1, 2, 3, 4, 5].reverse_each { |item| puts item }
```
* グルーピングする`group_by`なんてのもあったりする。
```ruby

```
## コマンド出力
* 「`」で囲まれた文字列はコマンドとして解釈される。OSに渡されて実行され、その結果が文字列で返却される。
```ruby
puts `ls -a`

#=> .
#=> ..
#=> main.rb
```
## Enumerable
### map
```ruby
[1, 2, 3, 4].map { |i| p i ** 2 }
```
