#!/bin/bash

flow="800M"
fhigh="900M"
fstep="8k"
gain="20"


freq=$flow
freq+=":"
freq+=$fhigh
freq+=":"
freq+=$fstep 

# export POSIXLY_CORRECT=1  
export LC_ALL=C
echo "Ready for scan without antenna? Press any key to continue."
read -n 1 -s
/Users/DSpreitz/Documents/Fliegen/OGN/rtl-sdr/build/src/rtl_power -1 -i 10 -f $freq -g $gain /tmp/no_antenna.csv

# Perform averaging
awk 'BEGIN{FS=",";i=7}{while (i<=NF){a+=$i;if(i==NF){print ($3+$4)/2,a/(NF-7); a=0;i=7;break}; i++}}' /tmp/no_antenna.csv > /tmp/no_antenna_avg.csv

echo "Ready for scan with antenna? Press any key to continue."
read -n 1 -s
/Users/DSpreitz/Documents/Fliegen/OGN/rtl-sdr/build/src/rtl_power -1 -i 10 -f $freq -g $gain /tmp/with_antenna.csv

# Perform averaging
awk 'BEGIN{FS=",";i=7}{while (i<=NF){a+=$i;if(i==NF){print ($3+$4)/2,a/(NF-7); a=0;i=7;break}; i++}}' /tmp/with_antenna.csv > /tmp/with_antenna_avg.csv


/usr/bin/paste /tmp/no_antenna_avg.csv /tmp/with_antenna_avg.csv > /tmp/antenna.csv
# echo "frequency,no_antanna_dbm, with_antenna_dbm,difference" > /tmp/antenna.csv 
/usr/bin/awk '{print $1,$2,$4,$2-$4}' /tmp/antenna.csv > /tmp/results.csv

LC_ALL=C /usr/bin/awk '{if($4<=0){print $1/1000000,$2,$3,$4,(10^(0.0000001/20)+1)/(10^(0.0000001/20)-1)} else {print $1,$2,$3,$4,(10^($4/20)+1)/(10^($4/20)-1)}}' /tmp/results.csv > /tmp/vswr.csv

exit
/usr/bin/awk '{if(($7-$46)>0) print ($3+$4)/2,$7-$46; else print ($3+$4)/2,"0.00001";}' /tmp/antenna.csv > /tmp/vswr.csv
cat /tmp/vswr.csv
echo "============"

# Perform averaging
awk 'BEGIN{FS=",";i=7}{while (i<=NF){a+=$i;if(i==NF){print ($3+$4)/2,a/(NF-7); a=0;i=7;break}; i++}}' /tmp/with_antenna.csv


#/usr/bin/awk '{print $1,(10^($2/20)+1)/(10^($2/20)-1)}' /tmp/vswr.csv
echo "Done."
exit
 

