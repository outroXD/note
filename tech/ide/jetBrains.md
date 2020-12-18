# Tips
## Intellij IDEA + GitlabでSSH経由でcloneする
* IntelliJでGitlabからcloneする時、設定方法が分かりづらかったのでメモ。  
* 前提として~/.ssh/configの各種設定は済んでいるbものとする。

1. `Welcome to IntelliJ IDEA`で`Get from VCS`を選択する。
2. `URL`は`<~/.ssh/configで設定したホスト名>:path/to/hoge.git`の形で指定する。  

(2)の設定画面例  
<img src="../../resource/tech/ide/jetBrains_1.png">