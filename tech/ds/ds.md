# pandas
## データフレームの切り出し
### データフレームの要素(単独)にアクセスする
```python
print(df.loc['Bob', 'age'])
print(df.iloc[3, 1])  # インデックス番号で指定する
```
### データフレームの要素(複数)にアクセスする
`df.iloc[取得する行の開始位置:取得する行の終了位置, [取得する列0, 取得する列1, ..., 取得する列N]`
```python
print(df.iloc[:2, [0, 2]])
```

## カテゴリ変数
### カテゴリ変数を取得したい
`Embarked`にカテゴライズされるカテゴリ変数を一覧表示する。
```python
embarked = train['Embarked'].unique()
embarked
```
### カテゴリ変数を変換する
```python
genders = {'male': 0, 'female': 1}
df_train['Sex'] = df_train['Sex'].map(genders)
```

## 欠損値
### 欠損値のある行を確認する
```python
df_train[df_train['Fare'].isnull()]
```
### 欠損値を埋める
```python
train.loc[train['PassengerId'].isin([62, 830]), 'Embarked'] = 'C'
```
### 欠損値を確認したい
`train`(データフレーム)内のカラムの欠損値を一覧表示する。
```python
train.isnull().sum()
```

## 四分位数
```python
# 25%の値を取得
p25 = np.percentile(train['Age'], 25)
# 50%の値を取得
p50 = np.percentile(train['Age'], 50)
```
* 対象のカラムに欠損値があると`nan`を返すので、欠損値を埋めた後実行すること。

## 行/列毎に処理
### 行毎に処理
データフレームの「行」をスコープに、処理を実施。  
`max,min`の例では「行の最大値・最小値」を対象にして、差を計算。  
行毎に計算された結果がデータフレームとして返却される。
```python
df.apply(lambda x: 行毎の処理)
# print(df.apply(lambda x: max(x) - min(x), axis=1))
```
### 列毎に処理
`axis=1`が指定しないと、列毎に処理を実施。  
下記例では「列の最大値・最小値」を対象にして差を計算。  
列毎に計算された結果がデータフレームとして返却される。  
```python
print(df.apply(lambda x: max(x) - min(x)))
```
### 要素毎に処理
要素毎に2で割って、その結果毎に奇数・偶数を出力する。  
```python
print(df.applymap(lambda x: 'odd' if x % 2 == 1 else 'even'))
```

# numpy
## ndarrayの各要素に関数を適用
`arr`がndarrayと仮定。  
`arr`の各要素について、0.7以上であれば1に、そうでなければ0に置き換える。
```python
arr = np.where(arr >= 0.7, 1, 0)
```