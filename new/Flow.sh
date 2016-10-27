#!/bin/sh

Stock=~/Documents/Stock/tools/analysis/Stock
Judge2=~/Documents/Stock/tools/analysis/Judge_v2
Judge3=~/Documents/Stock/tools/analysis/Judge_v3
scriptR=~/Documents/Stock/tools/R/script.R
script2R=~/Documents/Stock/tools/R/script2.R
gnu=~/Documents/Stock/tools/Gnu/set.gnu3
min=~/Documents/Stock/tools/analysis/min_500
max=~/Documents/Stock/tools/analysis/max_1000
sep=~/Documents/Stock/tools/awk_script/sep2.awk
int=~/Documents/Stock/tools/analysis/interest.sh

#お試し
Judge=~/Documents/Stock/tools/new/tmp
Sto=~/Documents/Stock/tools/new/Stock


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

#$Stock -f $TSV -dev $NUM >${FILE}_${NUM}.tsv

$Sto -f $TSV -dev $NUM >${FILE}_${NUM}.tsv #お試し


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

#echo $A,$D

#移動平均乖離率の信頼区間を測定
$Judge3 -f0 ${FILE}_${NUM}.tsv -f1 tmp3 > tmp2
mv tmp2 ${FILE}_${NUM}.tsv


#売買する日を判定する(売買 日付 判定値 金額)

#$Judge2 -f0 $FILE.tsv -f1 ${FILE}_${NUM}.tsv -x $A $B $C $D > ${FILE}.result.tsv

#$Judge -f0 $FILE.tsv -f1 ${FILE}_${NUM}.tsv -x $A $B $C $D > ${FILE}.close.result.tsv #お試し
#$Judge -f0 $FILE.tsv -f1 ${FILE}_${NUM}.tsv -open -x $A $B $C $D > ${FILE}.open.result.tsv #お試し

$Judge -f0 $FILE.tsv -f1 ${FILE}_${NUM}.tsv -open -x $A $B $C $D > ${FILE}.result.tsv #お試し




#rsi計算・phy計算
#../tools/new/Stock -f $FILE.tsv -rsi 14 > ${FILE}.rsi.tsv
#../tools/new/Stock -f $FILE.tsv -phy 12 > ${FILE}.phy.tsv

#RSIとPHY結果を利用して売買
#$Judge2 -f0 $FILE.tsv -f1 ${FILE}.rsi.tsv -x 20 60 40 80 > ${FILE}.rsi.result.tsv
#$Judge2 -f0 $FILE.tsv -f1 ${FILE}.phy.tsv -x 20 60 40 80 > ${FILE}.phy.result.tsv



#statsをまとめた表を出力
awk -f $sep ${FILE}.result.tsv > ${FILE}.stats.tsv

#awk -f $sep ${FILE}.close.result.tsv > ${FILE}.close.stats.tsv #お試し
#awk -f $sep ${FILE}.open.result.tsv > ${FILE}.open.stats.tsv #お試し




#画像ファイルを作成
#sed -e "s/MIN/$Min/g" $gnu |sed -e "s/UPPER/$D/g"|sed -e "s/LOWER/$A/g"|sed -e "s/Volume/$Volume/g"|sed -e "s/MAX/$Max/g"|sed "s/NUM/$NUM/g"|sed "s/Stock_number/$FILE/g" > ${FILE}.gnu


rm tmp tmp3 $TSV2