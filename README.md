# soal-shift-sisop-modul-1-F05-2021

# Soal 1
# Soal 2
Soal ini menggunakan data yang berasal dari *laporan-TokoShiSop.tsv* yang telah disediakan.<br>
Karena file berformat *tsv*, maka pada setiap sub-soal, AWK diinisiasi dengan menggunakan command :
```
LC_ALL=C awk -F '\t' ' 
```
`LC_ALL=C` digunakan sebagai *pre-caution* agar awk dapat membaca angka desimal pada data dengan benar. Hal ini berkaitan dengan penggunaan tanda titik (.) atau tanda koma (,) sebagai representasi tanda desimal.<br>
Sedangakan untuk `awk -F '\t'`, digunakan untuk menginisiasi awk sekaligus menetapkan nilai **tab (\t)** sebagai *field separator* (melihat file berformat *tsv*).<br><br>
## Soal 2a
Carilah *Row ID* beserta dengan *Profit Percentage* terbesar pada data (jika hasil *profit percentage* terbesar lebih dari 1, ambil data yang memiliki **Row ID** yang paling besar).<br> Dimana **profit percentage** dapat dicari dengan cara :
```
***Profit Percentage*** =  (***Profit*** : (***Sales*** - ***Profit***) x 100
```
Pada sub-soal ini, di bagian begin terdapat command :
```
BEGIN{
		maxPP = 0
		maxRID = 0
		isFirst = 1
	}
```
Command diatas digunakan untuk menginisiasi variabel tertentu yang akan digunakan untuk membantu jalannya program.<br>
`maxPP` digunakan untuk menyimpan nilai maksimum *Profit Percentage*. `maxRID` digunakan untuk menyimpan nilai maksimum *Row ID*. `isFirst` digunakan sebagai variabel pembantu untuk menginisiasi kedua variabel lainnya.<br><br>
 
 Pada bagian *action* awk, terdapat command :
 ```
 		if(NR != 1){
			profitPercentage = ($21/($18-$21))
			if(isFirst == 1){
				maxPP = profitPercentage
				maxRID = $1
				isFirst = 0
			}
			else{
				if(profitPercentage >= maxPP){
					maxPP = profitPercentage
					maxRID = $1
				}
			} 
		}			
```
Maksud dari kumpulan command diatas adalah, jika `NR` atau Number of Row tidak sama dengan 1 (artinya bukan header), maka hitung nilai `profitPercentage`
dengan menggunakan rumus `profitPercentage = ($21/($18-$21))`.Dimana `$21` adalah parameter *profit* dan `$18` adalah paramater *sales* yang didapatkan dari hasil 
***field separator karakter tab*** pada file yang disediakan Kemudian cek, jika ini merupakan hasil perhitungan pertama kali, maka masukkan nilai perhitungan
`profitPercentage` sebagai `maxPP` dan `RID ($1)` baris tersebut sebagai maxRID. Tujuannya adalah agar terdapat nilai yang dapat digunakan sebagai pembanding
untuk perhitungan nilai `profitPercentage` baris berikutnya. Kemudian, jika sudah bukan baris pertama lagi, maka berlaku perbandingan `profitPercentage >= maxPP`
untuk menentukan siapa yang memiliki `profiPercentage` yang paling besar.<br><br>

Pada bagian akhir script, terdapat command :
```
END{
		printf "Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%%.\n\n", maxRID, maxPP*100
	}
' Laporan-TokoShiSop.tsv > hasil.txt
```
Tujuannya adalah untuk menuliskan output yang didapatkan sesuai dengan format tersebut. Sedangkan untuk `Laporan-TokoShiSop.tsv > hasil.txt`, *Laporan-TokoShiSop.tsv* adalah
source file data yang digunakan pada operasi awk, dan `> hasil.txt` digunakan untuk mengirimkan hasil output script kedalam file **hasil.txt**
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
```  
20 1-31/7,2-31/4 * * bash ./home/juned/soal3b.sh
```
sedangkan untuk memindahkan file kita bisa memindahkan file gambar yang telah diunduh beserta log-nya, dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YYYY" bisa dengan script ```soal3b.sh``` berikut 
```
#!/bin/bash

PWD=`pwd`

bash soal3a.sh
now=$(date +"%d-%m-%Y")
mkdir "$now"

mv ./Koleksi_* "./$now"
mv ./Foto.log "./$now"
```

## soal 3c

Untuk soal ini kita diminta untuk mendownload gambar kucing dan kelinci secara bergantian tiap hari kemudian di simpan dalam folder Kucing_%mm%dd%Y untuk gambar kucing dan Kelinci_%mm%dd%Y untuk gambar kelinci. maka diawal script perlu diperiksa nama folder yang telah didownload (pada hari sebelumnya), jika filenya adalah kucing maka akan di download gambar kelinci begitu juga sebaliknya
```
#!/bin/bash

PWD=`pwd`

now=$(date +"%d-%m-%Y")
yes=$(date -d yesterday +"%d-%m-%Y")

kuckem="/Kucing_$yes"
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
```

## soal 3d
Untuk diminta men-zip semua folder kucing dan kelinci dan memberi password sesuai tanggal hari dimana dilakukan zipping
```
#!/bin/bash

PWD=`pwd`

now=$(date +"%m%d%Y")
echo $now
zip -P $now Koleksi.zip -r ./Kucing* ./Kelinci*
```
## soal 3e
Untuk soal ini kita diminta menjadwalkan yaitu setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya ter-zip saat kuliah saja, selain dari waktu yang disebutkan,semua folder ter-unzip dan tidak ada file zip sama sekali.
```
0 7 * * 1-5 zip -P `date +"%m%d%Y"` -r Koleksi.zip ./Kucing* ./Kelinci*
0 18 * * 1-5 unzip  -P `date +"%m%d%Y"` -r Koleksi.zip && rm Koleksi.zip
```



