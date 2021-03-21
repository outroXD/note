# GPU
# Tips
## An NVIDIA kernel module ‘nvidia-drm’ appears to already be loaded in your kernel.
* 公式からドライバーをwgetしてきて、実行したところ上記エラー。
* カーネルが`nvidia-drm`をロードしていることが原因。アンロードすればいいが、Xと連動しているので一度アンインストールを通して外す必要がある。
  * `TODO 詳しくないので、仕組みなども合わせて、他に方法あるのか調べる。`
```bash
sudo apt-get purge nvidia*
sudo -i
systemctl isolate multi-user.target
modprobe -r nvidia-drm

sudo bash ./NVIDIA-Linux-x86_64-<バージョン番号>.run --no-opengl-files --no-libglx-indirect --dkms
```
## Error response from daemon: linux runtime spec devices: could not select device driver “” with capabilities: [[gpu]]
* ドライバー更新後にdockerコンテナからGPUを指定したら、エラーでコンテナ動かなかった。
* ドライバー更新時、`apt-get purge`した為、dockerがGPUを認識する為のツールも一緒に削除してしまったのが原因。
* 以下スクリプトを実行して、コンテナがGPUを認識する為に必要なツールを落としてくる。

```bash
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt-get update
```
