# soal-shift-sisop-modul-1-F05-2021

# Soal 1
# Soal 2
# Soal 3
## soal 3a
Untuk mendowload file dari ```https://loremflickr.com/320/240/kitten``` kita dapat menggunakan perintah ```wget -a $PWD/Foto.log -O $PWD/"Koleksi_0$i"```
serta akan menyimpan log ke dalam file __Foto.log__

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
Karena gambar yang didownload random, akan ada kemungkinan gambarnya sama, untuk mengecek hal itu kita bisa melihat dari file __Foto.log__. Dengan mencari nilai site yang sama dari file __Foto.log__.


## soal 3b
## soal 3c
## soal 3d
## soal 3e
