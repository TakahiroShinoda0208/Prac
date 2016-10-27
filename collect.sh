sep=~/Documents/Stock/tools/awk_script/sep.awk
int=~/Documents/Stock/tools/analysis/interest.sh
score=~/Documents/Stock/tools/awk_script/each_score.awk 
date=~/Documents/Stock/tools/analysis/Date_v2
each_int=~/Documents/Stock/tools/analysis/each_interest.sh
awk_int=~/Documents/Stock/tools/awk_script/each_interest.awk 

#変数を定義
#X=$1
X=7

#cat ./*.stats.tsv > stats.out

#全体の結果集計

#awk -f $sep stats.out >> result.${X}.tsv

#利回りの計算

#$int >> interest.${X}.tsv

#取引日にちごとの結果集計

#cat ./*.result.tsv > tmp
#$date -f tmp > date.tsv

#各銘柄ごとに結果をまとめ出力

#for f in ./*.stats.tsv
#do
#    F=`basename $f`
#    printf ${F/.stats.tsv/}"\t"
#    awk -f $score $f
#done > score.tsv


#各銘柄ごとに年度別の利回りを計算しまとめる

for f in ./*.result.tsv
do
$each_int $f > ${f/result/interest}
done


#すべての銘柄情報を一つのファイルに書き込む

for f in ./*.interest.tsv
do
    F=`basename $f`
    printf ${F/.interest.tsv/}"\t"
    awk -f $awk_int $f
    printf "\n"
done > ./all.stats.${X}.tsv


#画像ファイルにタイトルを追加

#cat score.tsv |while read line
#do
 #   A=`echo $line |cut -f1 -d\t`
  #  FILE=${A/ /}.gnu
   # sed -i ".tmp" "s/TITLE/$line/g" $FILE
#done
#rm ./*.gnu.tmp



#画像ファイル出力

#for f in ./*.gnu
#do
#awk '{if($10>0)print $0}' ${f/.gnu/}.result.tsv > ${f/.gnu/}.plus.tsv
   # awk '{if($10<0)print $0}' ${f/.gnu/}.result.tsv > ${f/.gnu/}.minus.tsv

    #awk '{if($10>0)print $0}' ${f/.gnu/}.rsi.result.tsv > ${f/.gnu/}.rsi.plus.tsv
    #awk '{if($10<0)print $0}' ${f/.gnu/}.rsi.result.tsv > ${f/.gnu/}.rsi.minus.tsv

    #awk '{if($10>0)print $0}' ${f/.gnu/}.phy.result.tsv > ${f/.gnu/}.phy.plus.tsv
    #awk '{if($10<0)print $0}' ${f/.gnu/}.phy.result.tsv > ${f/.gnu/}.phy.minus.tsv
    #gnuplot $f
    #${f/.gnu/}.plus.tsv ${f/.gnu/}.minus.tsv
#done

