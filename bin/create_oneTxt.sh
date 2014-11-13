#!/bin/sh  
#============ get the file name ===========  

DATA=$1
InputDir=data/$DATA/
OutputFile=data/$DATA/corpus.txt
 
: > $OutputFile   #清空OutputFile  

for file_a in ${InputDir}/*.txt
do  
	echo ${InputDir}
	sed -n '1h;1!H;${g;s/\n/ /g;p;}' $file_a >> $OutputFile
done
