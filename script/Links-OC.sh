#!/bin/bash
#this script pulles the invtory lins from Ebiz auto for a single store
#below is where the url is set 
# this could be a good scritp for pulling only a set kind of link off any web site list.
URL='http://airstream-orange-county.ebizautos.com/inventory.aspx'
EXTRA='_page=' 
PAGE=1
MORE_PAGE=2
while [ $MORE_PAGE \> "1" ] ;do
	sleep 	1
	lynx -dump -source -accept_all_cookies  "$URL?$EXTRA$PAGE">dump-oc.tmp 
	#echo Lynx 
	grep detail dump-oc.tmp |sed -ne 's/.*\(http[^"]*\).*/\1/p'|sed 's/..$//'>>links-oc.txt 
	#this is the check to see if there is going to be a next page or not.. 
	let MORE_PAGE=$(grep -c next dump.tmp) 
	let PAGE=PAGE+1
	#echo sleeping
	sleep 30
	rm dump-oc.tmp
done

wc -l links.txt


