#!/bin/sh

Stock=~/Documents/Stock/tools/Stock
Judge=~/Documents/Stock/tools/Judge
Judge2=~/Documents/Stock/tools/Judge_v2
scriptR=~/Documents/Stock/tools/script.R
gnu=~/Documents/Stock/tools/Gnu/set.gnu3
min=~/Documents/Stock/tools/min_500
max=~/Documents/Stock/tools/max_1000
sep=~/Documents/Stock/tools/awk_script/sep2.awk
int=~/Documents/Stock/tools/interest.sh

NUM=$2

IN=`basename $1`
FILE=${IN/.csv/}
TSV=${FILE}.tsv

#csvファイルをtsvファイルに変換
cat $1 |tr -s ',' '\t' > $TSV

#株を与えて乖離率を計算

$Stock -f $TSV -x $NUM >${FILE}_${NUM}.tsv

#グラフの上限下限決定

Min=`$min $1 , 2`
Max=`$max $1 , 7`
Volume=`max $1 , 6`

#echo $Min
#echo $Max
#echo $Volume

#Rで平均分散計算
R --vanilla --slave --args ${FILE}.tsv ${FILE}_${NUM}.tsv < $scriptR >tmp

cat tmp |sed -e "s/\[1\] //g" >tmp2

A=`sed -n 1p tmp2`
B=`sed -n 2p tmp2`
C=`sed -n 3p tmp2`
D=`sed -n 4p tmp2`

#echo $A $B $C $D

#売買する日を判定する(売買 日付 乖離率  金額)

#$Judge -f0 $FILE.tsv -f1 ${FILE}_${NUM}.tsv -x $A $B $C $D > ${FILE}.result.tsv
$Judge2 -f0 $FILE.tsv -f1 ${FILE}_${NUM}.tsv -x $A $B $C $D > ${FILE}.result.tsv

awk -f $sep ${FILE}.result.tsv > ${FILE}.stats.tsv

cat ${FILE}.stats.tsv

#sed -e "s/MIN/$Min/g" $gnu |sed -e "s/UPPER/$D/g"|sed -e "s/LOWER/$A/g"|sed -e "s/Volume/$Volume/g"|sed -e "s/MAX/$Max/g"|sed "s/NUM/$NUM/g"|sed "s/Stock_number/$FILE/g" > ${FILE}.gnu



rm tmp tmp2