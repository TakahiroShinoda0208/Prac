set bars 3.0

set style fill empty
set multiplot layout 2,1
set ytics nomirror
set y2tics
set xdata time
set timefmt "%Y-%m-%d"

set yr[500:3500]
set y2r[0:1000000]

set datafile separator ","

plot '1377.csv' using 1:6 with boxes lc rgb "web-blue" axes x1y2,\
'1377.csv' using 1:2:4:3:7 with candlesticks lc rgb "web-green"

set yr[-0.1:0.1]
set y2r[0:100]
set datafile separator "\t"
plot '1377_7.tsv' using 1:2 with lines lw 0.3 lc rgb "steelblue",\
'1377_14.tsv' using 1:2 with lines lw 0.3 lc rgb "brown",\
'1377_30.tsv' using 1:2 with lines lw 0.3 lc rgb "dark-green"
