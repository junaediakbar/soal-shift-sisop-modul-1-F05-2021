#!/bin/bash

PWD=`pwd`

now=$(date +"%d-%m-%Y")
yes=$(date -d yesterday +"%d-%m-%Y")

kuckem="$PWD/Kucing_$yes"
if [ -d "$kuckem" ] 
then 
mkdir "Kelinci_$now"
#DOWNLOAD 23 FOTO DENGAN PENAMAAN YANG SESUAI
count=24
i=1
b=9
  for i in $(seq $count); 
  do
	if [ $i -le $b ]
	then
	wget -a $PWD/Foto.log -O $PWD/"Koleksi_0$i" https://loremflickr.com/320/240/bunny
 	else 
	wget -a $PWD/Foto.log -O $PWD/"Koleksi_$i" https://loremflickr.com/320/240/bunny
	fi
  done
#HAPUS YANG DUPLICATE
myarray=($(awk '/Location/ {print $2}' $PWD/Foto.log))

for ((i=0 ;i<23;i++))
do
for ((j=0 ;j<=i;j++))
do 
if [[ "$j" != "$i" && "${myarray[$j]}" == "${myarray[$i]}" ]]; then
	del=$((j+1))	
	if [ $del -le 9 ];
	then 
	rm $PWD/Koleksi_0$del
	else	
	rm $PWD/Koleksi_$del
	fi
fi
done
done
mv ./Koleksi_* "./Kelinci_$now"
mv ./Foto.log "./Kelinci_$now"

else 
mkdir "Kucing_$now"
#DOWNLOAD 23 FOTO DENGAN PENAMAAN YANG SESUAI
count=24
i=1
b=9
  for i in $(seq $count); 
  do
	if [ $i -le $b ]
	then
	wget -a $PWD/Foto.log -O $PWD/"Koleksi_0$i" https://loremflickr.com/320/240/kitten
 	else 
	wget -a $PWD/Foto.log -O $PWD/"Koleksi_$i" https://loremflickr.com/320/240/kitten
	fi
  done
#HAPUS YANG DUPLICATE
myarray=($(awk '/Location/ {print $2}' $PWD/Foto.log))

for ((i=0 ;i<23;i++))
do
for ((j=0 ;j<=i;j++))
do 
if [[ "$j" != "$i" && "${myarray[$j]}" == "${myarray[$i]}" ]]; then
	del=$((j+1))	
	if [ $del -le 9 ];
	then 
	rm $PWD/Koleksi_0$del
	else	
	rm $PWD/Koleksi_$del
	fi
fi
done
done
mv ./Koleksi_* "./Kucing_$now"
mv ./Foto.log "./Kucing_$now"


fi





