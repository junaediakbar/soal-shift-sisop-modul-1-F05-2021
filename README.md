# soal-shift-sisop-modul-1-F05-2021

# Soal 1
# Soal 2
# Soal 3
## soal 3a
Untuk mendowload file dari ```https://loremflickr.com/320/240/kitten``` kita dapat menggunakan perintah ```wget -a $PWD/Foto.log -O $PWD/"Koleksi_0$i"```serta akan menyimpan log ke dalam file __Foto.log__

```
#DOWNLOAD 23 FOTO DENGAN PENAMAAN YANG SESUAI
count=23
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
```
Karena gambar yang didownload random, akan ada kemungkinan gambarnya sama, untuk mengecek hal itu kita bisa melihat dari file __Foto.log__. Dengan mencari nilai situs yang sama dari file __Foto.log__ dengan menggunakan ```awk``` pada sebuah array ```myarray``` sebagai berikut: ```myarray=($(awk '/Location/ {print $2}' $PWD/Foto.log))```
lalu lakukan pemeriksaan dengan looping.
```
for ((i=0 ;i<23;i++))
do
for ((j=0 ;j<=i;j++))
do 
if [[ "$j" != "$i" && "${myarray[$j]}" == "${myarray[$i]}" ]]; then
	del=$((j+1))	
	if [ $del -le 9 ];
	then 
	rm -f $PWD/Koleksi_0$del
	else	
	rm -f $PWD/Koleksi_$del
	fi
fi
done
done
```
## soal 3b
untuk membuat crontab untuk __setiap tanggal 1 tujuh hari sekali (1,8,...)__ serta dari tanggal __2 empat hari sekali (2,6,...)__ bisa dengan
```  20 1-31/7,2-31/4 * * bash ./home/juned/soal3b.sh
```
sedangkan untuk
## soal 3c

## soal 3d

## soal 3e
