#!/bin/bash
#this script pulles the invtory lins from Ebiz auto
#Last update 1/26/17 link list
#below is where the url is set 
# this could be a good scritp for pulling only a set kind of link off any web site list.
URL='http://air-stream-los-angeles.ebizautos.com/inventory.aspx'
EXTRA='_page=' 
PAGE=1
MORE_PAGE=2
while [ $MORE_PAGE \> "1" ] ;do
	#echo Lynx
	#sleep 1	
	lynx -dump -listonly -nonumbers -accept_all_cookies  "$URL?$EXTRA$PAGE">dump.tmp 
	grep detail- dump.tmp |uniq >>links.txt
	#grep detail dump.tmp |sed -ne 's/.*\(http[^"]*\).*/\1/p'|sed 's/..$//'>>links.txt 
	#Chaning this one to a if else to check for the nest page. 1/26/17 
	if grep -q detail- dump.tmp; then
    	#echo found
		let PAGE=PAGE+1
		rm dump.tmp
	else
   		#echo not found
		let MORE_PAGE=1
	fi
	sleep 10
done

#
#this is where the loop starts for the CSV file 
#
for i in $(cat links.txt) ;do
FILE_NAME=$(echo $i|sed 's/^.\{51\}//g'|sed 's/.\{5\}$//')
#echo $FILE_NAME
#pulling out the year
MODLE_YEAR=$(echo $i|sed 's/^.\{51\}//g'|sed 's/.\{14\}$//'|sed 's/\-/ /g'|sed 's/_/ /'|cut -d' ' -f1)
#pulling out the maufacherer
MODLE_MANF=$(echo $i|sed 's/^.\{51\}//g'|sed 's/.\{14\}$//'|sed 's/\-/ /g'|sed 's/_/ /'|cut -d' ' -f2)
#pulling the type or modle
MODLE_TYPE=$(echo $i|sed 's/^.\{51\}//g'|sed 's/.\{14\}$//'|sed 's/\-/ /g'|cut -d' ' -f3|sed 's/\_/ /g')
#should be pulling trim level  may not working at this time.
MODLE_TRIM=$(echo $i|sed 's/^.\{51\}//g'|sed 's/.\{14\}$//'|sed 's/\-/ /g'|sed 's/\(new\|used\)//g'|cut -d' ' -f4)
#picks out new or used 
STOCK_TYPE=$(echo $i|sed 's/.\{14\}$//'|sed 's/.*-//g')
lynx -dump -accept_all_cookies $i >Files\/$FILE_NAME
#this group has to read the file not the "$i"
#getting the stock number
STOCK_NUMBER=$(cat Files\/$FILE_NAME|grep -i stock|sed 's/.Stock\ \# //g'|sed 's/ //g')
#Getting VIN
VIN_NUMBER=$(cat Files\/$FILE_NAME|grep VIN\ #|sed 's/VIN\ \#//g'|sed 's/ //g')
#pulling ext and int color working right 3/3/17
INT_COLOR=$(cat Files\/$FILE_NAME|grep -i -A1 "interior color"|tail -n 1)
EXT_COLOR=$(cat Files\/$FILE_NAME|grep -i -A1 "exterior color"|tail -n 1)
#pulling sold or not.
PRICE_MARK=$(cat Files\/$FILE_NAME|grep 'Price\|Sold'|head -n1)
#price showen
PRICE_SHOW=$(cat Files\/$FILE_NAME|grep '\$'|head -n 1|sed 's/\,//'|sed 's/.*\$//g')
let COUNT=COUNT+1
#Getting Location of Inventory 
if grep -q 92530 Files\/$FILE_NAME; then
    	#echo found
		STOCK_LOT=IE 
	else
   		#echo not found
		if 
			grep -q 92683 Files\/$FILE_NAME; then
    		#echo found
			STOCK_LOT=OC 
			else
   			#echo not found
			STOCK_LOT=LA
		fi
	fi
#echo $COUNT
echo $STOCK_LOT,$STOCK_NUMBER,$VIN_NUMBER,$MODLE_YEAR,$MODLE_MANF,$MODLE_TYPE,$MODLE_TRIM,$STOCK_TYPE,$EXT_COLOR,$INT_COLOR,$PRICE_MARK,$PRICE_SHOW, >>web_invtory.csv
#echo $STOCK_NUMBER,$VIN_NUMBER,$MODLE_YEAR,$MODLE_MANF,$MODLE_TYPE,$MODLE_TRIM,$STOCK_TYPE,$EXT_COLOR,$INT_COLOR,$PRICE_MARK,$PRICE_SHOW,$STOCK_LOT,
echo sleeping
sleep 20
rm -f Files\/$FILE_NAME
done 
rm links.txt
