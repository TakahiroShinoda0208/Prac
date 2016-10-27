BEGIN{
      OFS="\t";
      total=0;
      trans=0;
      win=0;
      inte=0;
      num=0;
      max=1;
      count=0;
      for (i = 0; i < 17; i++){
            list[i]=i;
      }
}
{
      total+=$4;
      trans+=$2;
      win+=$3;
      inte+=$6;
      if($5>max){
            max=$5
      };
      if($2!=0){
            num++
      };
      list[count]=$6;
      count++
}
END{
      printf total"\t";
      printf trans"\t";
      printf ("%4.2f",win/trans*100);
      printf "\t";
      printf("%4.2f",inte);
      printf "\t";      
      printf("%4.2f",inte/num);
      printf "\t";
      printf("%4.2f",total/max*100);
      printf "\t";
      for (i = 0; i < 17; i++){
            printf("%4.2f",list[i]);
            printf("\t");
      }
      
}