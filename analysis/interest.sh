echo "\n\ninterest per year(year,times,interest)"
grep '2000-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2000,SUM2,(SUM1/SUM0)*100}'
grep '2001-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2001,SUM2,(SUM1/SUM0)*100}'
grep '2002-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2002,SUM2,(SUM1/SUM0)*100}'
grep '2003-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2003,SUM2,(SUM1/SUM0)*100}'
grep '2004-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2004,SUM2,(SUM1/SUM0)*100}'
grep '2005-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2005,SUM2,(SUM1/SUM0)*100}'
grep '2006-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2006,SUM2,(SUM1/SUM0)*100}'
grep '2007-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2007,SUM2,(SUM1/SUM0)*100}'
grep '2008-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2008,SUM2,(SUM1/SUM0)*100}'
grep '2009-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2009,SUM2,(SUM1/SUM0)*100}'
grep '2010-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2010,SUM2,(SUM1/SUM0)*100}'
grep '2011-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2011,SUM2,(SUM1/SUM0)*100}'
grep '2012-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2012,SUM2,(SUM1/SUM0)*100}'
grep '2013-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2013,SUM2,(SUM1/SUM0)*100}'
grep '2014-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2014,SUM2,(SUM1/SUM0)*100}'
grep '2015-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2015,SUM2,(SUM1/SUM0)*100}'
grep '2016-' ./*.result.tsv |awk 'BEGIN{OFS="\t";SUM0=0;SUM1=0;SUM2=0}{SUM0+=$4;SUM1+=$10;SUM2++}END{print "\t"2016,SUM2,(SUM1/SUM0)*100}'