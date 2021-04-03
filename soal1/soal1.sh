#!/bin/bash
 
#soal 1a
 
log=`cat syslog.log | cut -f6- -d' '`

#soal 1b
err=`grep "ERROR" "syslog.log" | cut -d' ' -f7- | cut -d'(' -f1 | sort | uniq -c`

#soal 1c
counterr=`grep "ERROR" "syslog.log"| cut -d'(' -f2 | cut -d')' -f1 | sort | uniq -c`
countin=`grep "INFO" "syslog.log"| cut -d'(' -f2 | cut -d')' -f1 | sort | uniq -c`

#soal 1d
printf 'Error,Count\n' > error_message.csv
echo "$err"| sort -nr | grep -Eo '[0-9]{1,}' > count.csv
echo "$err"| sort -nr | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' | sed 's/.$//'> message.csv
 
paste message.csv count.csv | while IFS="$(printf '\t')" read -r f1 f2
do
    printf "$f1,$f2\n"
done >> error_message.csv

cat "error_message.csv"
rm message.csv
rm count.csv


#soal 1e
printf 'Username,INFO,ERROR\n' > user_statistic.csv
cat syslog.log | cut -d'(' -f2 | cut -d')' -f1 | sort | uniq -c | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' > name.csv
echo "$counterr" | grep -Eo '[0-9]{1,}' > errorcount.csv
echo "$counterr" | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' > errorname.csv
echo "$countin"| grep -Eo '[0-9]{1,}' > infocount.csv
echo "$countin" | tr -d '[0-9]' | sed -e 's/^[[:space:]]*//' > infoname.csv

while read username; do
    nameuser="$username"
    infouser=0
    erroruser=0
    paste infocount.csv infoname.csv | (while read infocount infoname; do
        if [ "$nameuser" == "$infoname" ]
        then
            infouser=$infocount
            break
        fi
    done
    paste errorcount.csv errorname.csv | (while read errorcount errorname; do
        if [ "$nameuser" == "$errorname" ]
        then
            erroruser=$errorcount
            break
        fi
    done
    printf "$nameuser,$infouser,$erroruser\n" >> user_statistic.csv))
done < name.csv
cat user_statistic.csv
rm name.csv
rm errorcount.csv
rm errorname.csv
rm infocount.csv
rm infoname.csv
