X=$1
sep=~/Documents/Stock/tools/awk_script/sep.awk
int=~/Documents/Stock/tools/interest.sh
date=~/Documents/Stock/tools/Date

awk -f $sep stats.out >> result.${X}.tsv
$int >> interest.${X}.tsv

cat ./*.result.tsv > tmp
$date -f tmp > date.tsv

rm tmp
rm stats.out
ls |grep -v 'result.tsv' |grep -v 'stats.tsv' |grep -v "interest.${X}.tsv"|grep -v "result.${X}.tsv"|grep -v "date.tsv"|while read line
do
rm $line
done
