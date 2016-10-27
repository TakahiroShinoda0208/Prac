for i in `seq 2000 2016`
do
    grep "$i-" $1 |awk -v year=$i 'BEGIN{OFS="\t";max=1;total=0;trans=0;win=0}{trans++;total+=$10;if($4>max){max=$4};if($10>0){win++}}END{print year,trans,win,total,max,total/max*100}'
done
