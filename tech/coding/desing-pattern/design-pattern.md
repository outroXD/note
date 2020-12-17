# デザインパターン

# Repository Pattern
## メリット
* LaravelでコーディングしていてEloquentは便利なものの、コントローラー上でDBに対する条件などをハードコードする同じような処理がそこら中に散らばっているのが気になった。
* ハードコードのミスでバグを仕込んだり、テストされていない(=信頼性の低い)同じような処理を1箇所にまとめたいと思った。
* 追加で実装を加える場合も、他の箇所で動いているコードを呼び出して使う方が、個人的には心理的な安全がある気がする。
* DIできるので、DBアクセス部分をテストに落とし込める。
## デメリット
* どのような単位でRepositoryクラスを切るかについての共通認識がないと各位好きな単位で処理を切ると思うので、ビジネスロジックのDBアクセスを移管しただけのクラス・メソッド群ができそう。
## Laravel + Repository Pattern
ユーザー情報を保持するusersテーブルがあるという前提での実装サンプル。

* `RepositoryInterface`: Repositoryのインターフェース。
* `RepositoryAbstract`: Repositoryの抽象クラス。
* `UsersRepository`: Usersモデルに対応するレポジトリ。
* `Users`: usersテーブルに対応するモデルクラス。

RepositoryInterface  
```php
interface RepositoryInterface
{
    // データ全権取得
    public function all($columns = ['*']);
    
    // ユーザーIDによる検索
    public function findById($id, $columns = ['*']);
}
```

RepositoryAbstract  
```php
abstract class RepositoryAbstract implements RepositoryInterface
{
    protected $model;
    
    public function __construct() 
    {
        $this->setModel();
    }
    
    abstract public function getModel();
    
    public function setModel() 
    {
        $this->model = app()->make(
            $this->getModel()
        );
    }
    
    public function all($columns = ['*'])
    {
        return $this->model->all($columns);
    }
    
    public function findById($id, $columns = ['*'])
    {
        return $this->model->find($id, $columns);
    }
}
```

UsersRepository　　
```php
class UserRepository extends RepositoryAbstract
{
    public function getModel()
    {
        return User::class;
    }

    public function authenticate($attribute)
    {
        if (!Auth::attempt($attribute)) {
            return false;
        }

        return true;
    }
}
```

呼び出し側サンプル  
動作確認はしていない。
```php
class SampleClass 
{
    public function __construct(UserRepository $_userRepo)
    {
        $this->userRepo = $_userRepo;
    }
    
    public function hoge()
    {
        $users = $this->userRepo->all($userParam);
    }
}
```