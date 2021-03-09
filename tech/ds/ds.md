# pandas
## カテゴリ変数
### カテゴリ変数を取得したい
`Embarked`にカテゴライズされるカテゴリ変数を一覧表示する。
```python
embarked = train['Embarked'].unique()
embarked
```

## 欠損値
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
