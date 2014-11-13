#!/bin/bash


DEMO=$1

mkdir -p data/$DEMO/oneTxt
mkdir -p data/$DEMO/db

CORPUS_PATH=data/$DEMO
OutputFile=data/$DEMO/oneTxt/corpus.txt

: > $OutputFile   #清空OutputFile  

for file_a in ${CORPUS_PATH}/*.txt
do  
	sed -n '1h;1!H;${g;s/\n/ /g;p;}' $file_a >> $OutputFile
done

bin/import_corpus.py $CORPUS_PATH/db $OutputFile

bin/export_corpus.py $CORPUS_PATH/db/ $CORPUS_PATH/db/corpus.txt
	
echo "    Corpus available: $CORPUS_PATH"

