#!/bin/sh
# サブディレクトリ以下にあるファイルの内容を Evernote へノートとして追加する。
# 二回目以降は追加・更新されたファイルだけを追加する。
# 更新の場合も新たなノートとして追加される。
# 実際の処理は Geeknote を利用するが、フォークした下記バージョンを利用する。
# https://github.com/jeffkowalski/geeknote/

LAST_EXECUTED_FILE=".add2evernote-last";
# CMD 変数に格納する際に括弧に対するエスケープが消えるので二重にエスケープしておく
FINDOPTS="-not \\( -name .DS_Store -o -name $LAST_EXECUTED_FILE -o -name `basename $0` \\) -type f"
GEEKNOTEOPTS=""

# 外部ディレクトリから実行された場合を考慮して移動する
pushd .
cd `dirname $0`
echo "Directory : `pwd`"

# スクリプトを書き直した時に全て再同期したい場合がある
while getopts fn:h OPT
do
  case $OPT in
    "f" ) FORCE="TRUE" ;;
    "n" ) NOTEBOOK=$OPTARG ;;
  esac
done

if [ "$FORCE" = "TRUE" ]; then
    rm -i $LAST_EXECUTED_FILE
fi

if [ ! "$NOTEBOOK" = "" ]; then
    GEEKNOTEOPTS="$GEEKNOTEOPTS --notebook $NOTEBOOK"
fi

if [ -f $LAST_EXECUTED_FILE ]; then
    FINDOPTS="$FINDOPTS -newer $LAST_EXECUTED_FILE "
fi

# -exec では cat {} | が動作しなかったので、 xargs で代用
CMD="find . $FINDOPTS | xargs -I{} sh -c \"echo {} ; cat \"{}\" | geeknote create --title \"{}\" $GEEKNOTEOPTS --content -\""
echo "Command   : $CMD"
eval ${CMD}

echo `date` > $LAST_EXECUTED_FILE

popd
