#!/bin/bash

#Nomor 2A
LC_ALL=C awk -F '\t' ' 
	BEGIN{
		maxPP = 0
		maxRID = 0
		isFirst = 1
	}
	{	
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
	}
	END{
		printf "Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%%.\n\n", maxRID, maxPP*100
	}
' Laporan-TokoShiSop.tsv > hasil.txt

#Nomor 2B	
LC_ALL=C awk -F '\t' ' 
	{	
		split($3,dateTime,"-")
		if(dateTime[3] == "17" && $10 == "Albuquerque"){
			names[$7] 	
		}
	}
	END{
		printf "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n"
		for(name in names){
			printf "%s\n", name
		}
	printf "\n"	
	}
' Laporan-TokoShiSop.tsv >> hasil.txt

#Nomor 2C
LC_ALL=C awk -F '\t' '
	{	
		if(NR != 1){
			arr[$8]++
		}
	}
	END{
		isFirst = 1;
		for(types in arr) {  
			if (isFirst == 1){
				min = arr[types]
				isFirst = 0
				continue
			}
			else if (arr[types] < min){
				minTypes = types
				min = arr[types]
			}
		}
		
		printf "Tipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi\n\n", minTypes, min		
	}
' Laporan-TokoShiSop.tsv >> hasil.txt

#Nomor2D
LC_ALL=C awk -F '\t' '
	{
		if(NR != 1){
			arr[$13]+=$21
		}
	}
	END{
		isFirst = 1
		for(region in arr){
			if (isFirst == 1){
				min = arr[region]
				isFirst = 0
				continue
			}
			else if (arr[region] < min){
				minRegion = region
				min = arr[region]
			}
		}
		printf "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.4f\n", minRegion, min		
	}
' Laporan-TokoShiSop.tsv >> hasil.txt