# Laravel

# セッション
## セッションの基本的な仕組み概要
セッションはクライアント側のブラウザとサーバーが通信する中で、ステートレスなHTTP通信の中で「状態」を表現する為の技術。  
クライアント側のブラウザではCookieを使ってセッションキーをWebページのドメインに紐づかせる形で保持し、サーバーとの通信の都度それを送る。  
サーバー側では送られてきたセッションキーを元に内部で保持しているセッション情報を特定し、メモリにその内容を載せることで状態を復元する。
## Laravelのセッション
### パラメータ
#### .env
* SESSION_DRIVER
  + セッション情報をどのような形で保持するかを指定。
  + `file`: セッション情報をファイルで保持する。
* SESSION_LIFETIME
  + セッションの有効期間を秒数で指定。
    * (ex) `有効期限が2時間`: SESSION_LIFETIME=120
#### session.php
こっちでは「セッションそのものに関する設定」、「Cookieの設定」を持ってる。
* same_site
  * SameSite属性の値を設定する。
    * `lax`: デフォルト値。同じファーストドメインが同じ場合のみCookieを送信する。
    * `none`: 通信先にCookie情報を送信する。 
  * Webアプリを組む上で把握しておきたい地味なハマりどころあり。
    


# Tips
## tinkerで色々
tinker(REPL)を使うことで、今の環境変数とか、スクリプトの実行とかできる。  
  
起動
```bash
php artisan tinker
```
### Laravelが読み込んでいるDB情報を確認
```bash
>>> DB::connection()->getConfig();
=> [
     "driver" => "mysql",
     "host" => "goat-charts-db",
     "port" => "3307",
     "database" => "goat",
     "username" => "root",
     "password" => "password",
     "unix_socket" => "",
     "charset" => "utf8mb4",
     "collation" => "utf8mb4_unicode_ci",
     "prefix" => "",
     "prefix_indexes" => true,
     "strict" => true,
     "engine" => null,
     "options" => [],
     "name" => "mysql",
   ]
```
## 外部サービス(別ドメイン)を使用するときはCookieに依存しない組み方を前提にするか、外部サービスAPIを使う
* 別ドメイン上に存在する外部決済サービスを使用した時、外部サービス→Laravelアプリケーションの戻ってくる遷移で認証切れが発生した。
* Laravel(というか普通のWebアプリ)ではCookieを使ってセッションを実現する。
* Laravel→外部サービスの遷移では、Laravelの設定によってはCookieが外部サービスへ送信されない。その結果Laravel内ではセッション情報を一意に特定できず、セッションを使用する業務ロジックでバグが発生した。
* 別ドメインへCookieを送信するかどうかは、SameSite属性で制御する。
* SameSite属性の扱いはブラウザによって異なる点に注意する。

1. セッションが生成できない導線が存在する場合は、セッションが存在する前提でビジネスロジックを書かないこと。
2. 認可に関する情報をセッションに入れて持ち回る場合、面倒&コストがあってもミドルウェアなどでセッションを生成する処理を挟んだ方が無難。  
セッションと密結合なビジネスロジックのバグは、プロジェクト後半などで見つかるとリカバリーのコストが全体に波及してしまう。
3. だからといってSameSite属性をnoneにしてセキュリティレベルを落とすことは間違いだし、ブラウザに依存する作りになってしまう。
4. そもそも別ドメインへの遷移がある場合は、外部サービス選定時にAPIが提供されているサービスを選ぶべき。これならドメインを跨がないので、上記問題は解決できる。

## Laravel + React + Typescriptの環境を構築する
* フロントはReactを使いたい。
* 深く掘ると色々と気になる部分はあるのかも知れないが、暫くはcraに面倒な部分を任せたい。
* craを使える形で、Laravel + React環境を構築する。

1. 必要なライブラリをインストールする。
   ```bash
   composer require laravel/ui
   ```
2. 新規プロジェクトLaravelを作成する。
   ```bash
   composer create-project --prefer-dist laravel/laravel <プロジェクト名>
   ```
3. Reactプロジェクトを作成する。  
   下記例ではfrontというディレクトリがフロントのソース格納先として作成される。
   ```bash
   cd ~/path/to/<プロジェクト名>
   npx create-react-app front --template typescript
   ```
4. LaravelとReactを繋げる。ビルドスクリプトは必要に応じてデプロイ先を変更する。  
   `front/package.json`を編集する。  
   ここでは適当にpublicに載せてる。フロントエンド用ディレクトリがある場合、そこにビルド先を差し替える。  
   ```json
   "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "build:prod": "npm run-script build && cp -r build/* ../public",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
   },
   ```
5. Reactプロジェクト(front配下)をコンパイルする。
   ```bash
   npm run build:prod
   ```
6. 適当にルートを設定する。
   ```php
   //Route::get('/', function () {
   //    return view('welcome');
   //});

   Route::fallback(function () {
       return file_get_contents(public_path('index.html'));
   });
   ```
7. Laravelを起動する。
   ```bash
   php artisan serve
   ```

* `npm`や`npx`などは本当はローカルPC環境に入れたくない。全部コンテナ上で完結させたいが、コンテナ力不足なのと、考え方としてあっているのかに自信がないので取り敢えずローカルに入れた。
* 所謂マイクロサービスアーキテクチャ的なイメージ？でコンテナ間で連動させ、その「結果」をホストPCに反映させれば良いのだろうけど、そもそも面倒臭い。