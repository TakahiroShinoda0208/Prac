awk BEGIN{
      OFS=",";
      FS=",";
      MUL=0
}
{
      if($5 != $7){
            MUL=($7/$5);
            print $1,$2*MUL,$3*MUL,$4*MUL,$5*MUL,$6,$7
      }else{
            print $0
      }     
}

