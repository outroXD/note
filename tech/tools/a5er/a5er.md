# A5ER
## OSXでwineを使ってA5ERを起動
### 各種インストール
#### A5ERのexe
[ここからDL](https://www.vector.co.jp/soft/dl/winnt/business/se422726.html)
* `A5:SQL Mk-2(x64 edition)2.15.4`をDL。
* 起動してシェルから解凍先ディレクトリへ移動。
#### wine
```bash
brew install xquartz wine-stable
```
### 起動
```bash
keisuke@MacBook-Pro a5m2_2.15.4_x64 % ls -al
total 85256
drwx------@ 31 keisuke  staff       992  3 19 01:17 .
drwx------@ 15 keisuke  staff       480  3 19 01:17 ..
-rw-rw-r--@  1 keisuke  staff   1753088  1 17 09:41 A5M2.ENU
-rw-rw-r--@  1 keisuke  staff  37895168  1 17 09:41 A5M2.exe
-rw-rw-r--@  1 keisuke  staff      2101  6 28  2020 TileServerList.txt
-rw-rw-r--@  1 keisuke  staff      7905  1 17 09:41 VirusCheck.txt
-rw-rw-r--@  1 keisuke  staff       151  1 17 09:41 build_info.txt
-rw-rw-r--@  1 keisuke  staff    333632  5 31  2020 concrt140.dll
-rw-rw-r--@  1 keisuke  staff     49674  1 17 09:41 history.txt
-rw-rw-r--@  1 keisuke  staff    160768  5 31  2020 libbson-1.0.dll
-rw-rw-r--@  1 keisuke  staff    369664  5 31  2020 libmongoc-1.0.dll
-rw-rw-r--@  1 keisuke  staff      4884  5 31  2020 license.txt
-rw-rw-r--@  1 keisuke  staff      4354  5 31  2020 license_en.txt
-rw-rw-r--@  1 keisuke  staff    633152  5 31  2020 msvcp140.dll
-rw-rw-r--@  1 keisuke  staff     11672 12 20 12:07 readme.txt
-rw-rw-r--@  1 keisuke  staff      9485  9 20 14:24 readme_en.txt
-rw-rw-r--@  1 keisuke  staff     65024  5 31  2020 sample\CreateTableDefinition.xls
-rw-rw-r--@  1 keisuke  staff     11817  5 31  2020 sampledb\ShoppingSite.a5er
-rw-rw-r--@  1 keisuke  staff    245760  5 31  2020 sampledb\ShoppingSite.mdb
-rw-rw-r--@  1 keisuke  staff      4872  5 31  2020 scripts\Tool\SqlEmbededStr.dms
-rw-rw-r--@  1 keisuke  staff       757  5 31  2020 scripts\TreeDB\FavoritesExport.dms
-rw-rw-r--@  1 keisuke  staff       939  5 31  2020 scripts\TreeDB\FavoritesImport.dms
-rw-rw-r--@  1 keisuke  staff       385  5 31  2020 scripts\TreeDB\OpenSchemaTable.dms
-rw-rw-r--@  1 keisuke  staff      4781  5 31  2020 scripts\TreeDB\oracle_procedureSources.dms
-rw-rw-r--@  1 keisuke  staff      3712  5 31  2020 scripts\TreeDB\oracle_viewSources.dms
-rw-rw-r--@  1 keisuke  staff       799  5 31  2020 scripts\TreeDB\reccount_query.dms
-rw-rw-r--@  1 keisuke  staff       496  5 31  2020 scripts\TreeTB\CsvCopy.dms
-rw-rw-r--@  1 keisuke  staff      2890  5 31  2020 scripts\TreeTB\InsertStatements.dms
-rw-rw-r--@  1 keisuke  staff       527  5 31  2020 scripts\TreeTB\TableInfo.dms
-rw-rw-r--@  1 keisuke  staff   1918464  5 31  2020 sqlite3.dll
-rw-rw-r--@  1 keisuke  staff     87888  5 31  2020 vcruntime140.dll

keisuke@MacBook-Pro a5m2_2.15.4_x64 % wine64 A5M2.exe
```