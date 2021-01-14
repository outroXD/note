# Java
# 用語
## インクリメンタルビルド

# tips
## `java: javacTask: ソース・リリース8にはターゲット・リリース1.8が必要です`
* EclipseからIntelliJ IDEAに移行するときに発生。
```bash
Parsing java... [tsform]
java: javacTask: ソース・リリース8にはターゲット・リリース1.8が必要です
java: Compilation failed: internal java compiler error
java: Errors occurred while compiling module 'tsform'
javac 1.8.0_275 was used to compile java sources
Finished, saving caches...
Compilation failed: errors: 1; warnings: 0
Executing post-compile tasks...
Loading Ant configuration...
Running Ant tasks...
Synchronizing output directories...
```
* IDEの各種設定
  * `Use compiler`: javac
  * `Project bytecode version`: 6
* Eclipseでは同じようなIDE設定で実行までできているので、どこに差分があるのか分からない。
* `ソース・リリース8にはターゲット・リリース1.8が必要です`とあるが、何をもって1.8が必要と判断しているのか理解していない。
  * `javac 1.8.0_275 was used to compile java sources`とあり、確かにローカル環境に1.8.0_275が存在しているので、1.6系でコンパイルしなおせば行ける？
  * TODO 要調査
* `File` > `Project Structure` > `Project Settings` > `Project` > `Project language level`を8から6に落としたら、このエラーは通った。
  * 設定されたProject language levelからローカルにインストールされているjavacのバージョンと紐付けて、そのバージョンでコンパイルしているのかな。
    
## `java: メソッドはスーパータイプのメソッドをオーバーライドまたは実装しません`
* EclipseからIntelliJ IDEAに移行するときに発生。
* Eclipseでは問題ないのに、IntelliJ IDEAからだとエラーでコンパイル通らない。

## `<パッケージ名>を解決できません。必要な .class ファイルから間接的に参照されています`
