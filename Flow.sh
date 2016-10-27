#!/bin/sh

Stock=~/Documents/Stock/tools/analysis/Stock
Judge=~/Documents/Stock/tools/analysis/Judge
Judge2=~/Documents/Stock/tools/analysis/Judge_v2
Judge3=~/Documents/Stock/tools/analysis/Judge_v3
scriptR=~/Documents/Stock/tools/R/script.R
script2R=~/Documents/Stock/tools/R/script2.R
gnu=~/Documents/Stock/tools/Gnu/set.gnu3
min=~/Documents/Stock/tools/analysis/min_500
max=~/Documents/Stock/tools/analysis/max_1000
sep=~/Documents/Stock/tools/awk_script/sep2.awk
int=~/Documents/Stock/tools/analysis/interest.sh



#変数を定義
NUM=7
#NUM=$2
IN=`basename $1`
FILE=${IN/.csv/}
TSV=${FILE}.tsv
TSV2=${TSV}2


#csvファイルをtsvファイルに変換
cat $1 |tr -s ',' '\t' > $TSV
sort -nrk 7 $TSV|cut -f7 > $TSV2

#株を与えて乖離率を計算

$Stock -f $TSV -x $NUM >${FILE}_${NUM}.tsv

#グラフの上限下限決定
Max=`head -n1 $TSV2|awk '{print $1+100}'`
Min=`$min $1 , 2`
Volume=`max $1 , 6`

#Rで平均分散計算
R --vanilla --slave --args ${FILE}.tsv ${FILE}_${NUM}.tsv < $scriptR >tmp
R --vanilla --slave --args ${FILE}.tsv ${FILE}_${NUM}.tsv < $script2R >tmp3

cat tmp |sed -e "s/\[1\] //g" >tmp2
mv tmp2 tmp
cat tmp3 |sed -e "s/\[1\] //g" >tmp2
mv tmp2 tmp3

A=`sed -n 1p tmp`
B=`sed -n 2p tmp`
C=`sed -n 3p tmp`
D=`sed -n 4p tmp`

#いどう平均乖離率の信頼区間を測定
$Judge3 -f0 ${FILE}_${NUM}.tsv -f1 tmp3 > tmp2
mv tmp2 ${FILE}_${NUM}.tsv

#売買する日を判定する(売買 日付 乖離率  金額)

#$Judge -f0 $FILE.tsv -f1 ${FILE}_${NUM}.tsv -x $A $B $C $D > ${FILE}.result.tsv
$Judge2 -f0 $FILE.tsv -f1 ${FILE}_${NUM}.tsv -x $A $B $C $D > ${FILE}.result.tsv

#statsをまとめた表を出力
awk -f $sep ${FILE}.result.tsv > ${FILE}.stats.tsv


#sed -e "s/MIN/$Min/g" $gnu |sed -e "s/UPPER/$D/g"|sed -e "s/LOWER/$A/g"|sed -e "s/Volume/$Volume/g"|sed -e "s/MAX/$Max/g"|sed "s/NUM/$NUM/g"|sed "s/Stock_number/$FILE/g" > ${FILE}.gnu


rm tmp tmp3 $TSV2