# add2evernote.sh

テキストファイルの内容をコマンドで Evernote に追加する。
howm のファイルを Evernote に集める為に作った。

- Geeknote が必要。フォークした下記バージョンで動作を確認している。
  - https://github.com/jeffkowalski/geeknote/
- サブディレクトリ以下にあるファイルの内容を Evernote へノートとして追加する。
- 二回目以降は追加・更新されたファイルだけを追加する。
- 更新の場合も新たなノートとして追加される。


```bash
# Usage

# 実行したディレクトリ以下のファイルを Evernote に追加
./add2evernote.sh

# もう一度全て追加したい場合
./add2evernote.sh -f

# ノートを指定したい場合
./add2evernote.sh -n notename

```
