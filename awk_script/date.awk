BEGIN{
OFS="\t"
a00=0;
a01=0;
a02=0;
a03=0;
a04=0;
a05=0;
a06=0;
a07=0;
a08=0;
a09=0;
a10=0;
a11=0;
a12=0;
a13=0;
a14=0;
a15=0;
a16=0;
a17=0;
a18=0;
a19=0;
a20=0;



}
{
      total+=$10;
      if($10 > 0){plus0+=$10;plus1++}
      else if($10 == 0){equal0+=$10;equal1++}
      else if($10 < 0){minus0+=$10;minus1++};
      if(max < $10){max=$10};
      if(min > $10){min=$10};
      
}
END{
      print "損益\t",total
      print "最大値\t",max
      print "最小値\t",min
      print "利益\t",plus0,"\t",plus1
      print "損害\t",minus0,"\t",minus1
      print "同等\t",equal0,"\t",equal1
}

