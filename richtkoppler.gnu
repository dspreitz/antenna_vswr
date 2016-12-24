# plot "/Users/DSpreitz/Desktop/Ralf/vswr.csv" using 1:2 with line t "Grundrauschen", "" using 1:3 with line t "Antenne", "" using 1:4 with line t "Differenz", "" using 1:5 with linespoints t "VSWR" axes x1y2, "/Users/DSpreitz/Desktop/Ralf/flarm.csv" with linespoints t "Flarm"
set yrange [-50:30]
set y2range [1:3]
set y2tics add ("1" 1, "1.1" 1.1, "1.2" 1.2, "1.3" 1.3, "1.4" 1.4)
set grid x y2
set ylabel "dbm"
set y2label "VSWR"
set logscale y2
plot "/tmp/vswr.csv" using 1:2 with line t "Grundrauschen", "" using 1:3 with line t "Antenne", "" using 1:4 with line t "Differenz", "" using 1:5 with linespoints t "VSWR" axes x1y2, "/Users/DSpreitz/Desktop/Ralf/flarm.csv" with linespoints t "Flarm"


pause -1


replot
