# ant


# tips
## 公式サイトからダウンロードした旧バージョンantをIDEで指定したら`cannot read zip file`エラー
### 事象
1. [公式サイト](https://archive.apache.org/dist/ant/binaries/) より`apache-ant-1.9.2-bin.zip`をダウンロード・解凍する。
2. eclipseでダウンロードしてきたantを指定する。
   * `build.xmlを右クリック > 実行 > 外部ツールの構成 > クラスパス > Antホーム`より`/path/to/ant/dir/libexec`を指定。
3. intelliJ IDEAでダウンロードしてきたantを指定する。
4. `build.xmlを右クリック > 実行 > Antビルド`でAntタスクを実行。
5. エラー発生。
   ```bash
   エラー:/Volumes/Extreme SSD/work/atled/libs/ant/apache-ant-1.9.15/lib/._ant-antlr.jar の読み込みエラーです。cannot read zip file 
   ```
### 対応
* zipファイルが読めないと言うことなので、ファイルに破損があるのではと思い、brew経由でantをダウンロード。
  ```bash
  brew install ant@1.9
  brew link --force ant
  ant --version
  ```
* IDEからだと権限の問題で`/usr/*`を参照することができなかった。取り急ぎ`/usr/local/Cellar/ant@1.9/<version number>`をデスクトップにコピーしてきて、IDEで参照した。
* 上記エラーは出力されなくなった。公式のzipと比べてどんな差分があるのかよく分からないが、権限問題を解決して、brew経由で落としたライブラリを参照する方が良さそう。