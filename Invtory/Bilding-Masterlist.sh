#!/bin/bash
##this is what is going to be for all the sales managers to know what is what.
dropbox="/home/jeremy/.dropscrit/dropbox_uploader.sh"

##download web site invtory
$dropbox download Invtory/Web-site Working/Web-site
##download CDK Raw data
$dropbox download Invtory/CDK-Raw Working/

##combinding all stors in to one master list CDK-all-stores.
cat Working/CDK-Raw/ALA.csv >> Working/CDK-All-Store.csv
sed 1d Working/CDK-Raw/AIE.csv >>Working/CDK-All-Store.csv
sed 1d Working/CDK-Raw/AOC.csv >>Working/CDK-All-Store.csv
sed 1d Working/CDK-Raw/ALV.csv >>Working/CDK-All-Store.csv
$dropbox upload Working/CDK-All-Store.csv Invtory/CDK-Raw-All-Store.csv
##making cleaner Masterlist
sed 1d Working/CDK-All-Store.csv| sponge Working/CDK-All-Store.csv
tr ' ' '_' <Working/CDK-All-Store.csv|sponge Working/CDK-All-Store.csv
##removing all the $ in the file so it that will not trip up my script 
sed -i 's/\$//g' Working/CDK-All-Store.csv
##looping in file to read each line.
for i in $(cat Working/CDK-All-Store.csv) ;do
  ##LIST OF ITEMS FOR THE NEW CSV FILES
  STOCK_NUMBER=$(echo $i|cut -d ',' -f1|tr -d '[:space:]')
  STOCK_TYPE=$(echo $i|cut -d ',' -f2|tr -d '[:space:]')
  MODEL_YEAR=$(echo $i |cut -d ',' -f3|tr -d '[:space:]')
  MAKE=$(echo $i |cut -d ',' -f4|tr -d '[:space:]')
  MODEL=$(echo $i |cut -d ',' -f5|tr -d '[:space:]')
  MODEL_NUMBER=$(echo $i |cut -d ',' -f6|tr -d '[:space:]')
  OUTSIDE_COLOR=$(echo $i |cut -d ',' -f9|tr -d '[:space:]')
  INSIDE_COLOR=$(echo $i |cut -d ',' -f10|tr -d '[:space:]')
  SALE_PRICE=$(echo $i |cut -d ',' -f12|tr -d '[:space:]'|xargs printf "$%.0f"|sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta')
  MSRP=$(echo $i |cut -d ',' -f30|tr -d '[:space:]'|xargs printf "$%.0f"|sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta')
  INVOICE=$(echo $i |cut -d ',' -f13|tr -d '[:space:]'|xargs printf "$%.0f"|sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta')
  BALANCE=$(echo $i |cut -d ',' -f14|tr -d '[:space:]'|xargs printf "$%.0f"|sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta')
  COMPANY_NUMBER=$(echo $i |cut -d ',' -f16|tr -d '[:space:]')
  AGE=$(echo $i |cut -d ',' -f17|tr -d '[:space:]')
  DEALER_NOTES=$(echo $i |cut -d ',' -f22|tr -d '[:space:]')
  VIN_NUMBER=$(echo $i |cut -d ',' -f19|tr -d '[:space:]')
##This is setting the varable LOCATED based on what company it cames from.
  case $COMPANY_NUMBER in
    14 )
    LOCATED=AIE
      ;;
    15 )
    LOCATED=ALA
      ;;
    16 )
    LOCATED=AOC
      ;;
    26 )
    LOCATED=ALV
      ;;
#  esac
##Managers invtory
echo $STOCK_NUMBER,$STOCK_TYPE,$MODEL_YEAR,$MAKE,$MODEL,$MODEL_NUMBER,$OUTSIDE_COLOR,$INSIDE_COLOR,$AGE,\"$MSRP\",\"$SALE_PRICE\",\"$BALANCE\",\"$INVOICE\",$LOCATED,$VIN_NUMBER,$DEALER_NOTES,>>Working/Managers-Invtory.tmp
##Sales person invotry
echo $STOCK_NUMBER,$STOCK_TYPE,$MODEL_YEAR,$MAKE,$MODEL,$MODEL_NUMBER,$OUTSIDE_COLOR,$INSIDE_COLOR,$AGE,\"$MSRP\",\"$SALE_PRICE\",$LOCATED,$VIN_NUMBER,$DEALER_NOTES,>>Working/Sales-All-Invtory.tmp
##Physical invtory
echo $STOCK_NUMBER,$STOCK_TYPE,$MODEL_YEAR,$MAKE,$MODEL,,$LOCATED,$VIN_NUMBER,$DEALER_NOTES,>>Working/Physical-All-Invtory.tmp
done
##Managers Invtory
echo "stock No,Type,Year,Make,Model,Model#,ExtColor,IntColor,Age,MSRP,SalePrice,Balance,Invoice,LOT,VIN,Notes," >Working/Managers-Invtory.csv
cat Working/Managers-Invtory.tmp >>Working/Managers-Invtory.csv
$dropbox upload Working/Managers-Invtory.csv Invtory/Managers-Invtory.csv
##Sales Person Invtory
echo "stock No,Type,Year,Make,Model,Model#,ExtColor,IntColor,Age,MSRP,SalePrice,LOT,VIN,Notes," >Working/Sales-All-Invtory.csv
grep -F -eNEW -eUSED Working/Sales-All-Invtory.tmp >>Working/Sales-All-Invtory.csv
cat Working/Sales-All-Invtory.tmp >>Working/Sales-All-Invtory.csv
$dropbox upload Working/Sales-All-Invtory.csv Invtory/Sales-All-Invtory.csv
##Physical invtory for alias
echo "stock No,Type,Year,Make,Model,Model#,LOT,Store,VIN,Notes," >Working/Sales-All-Invtory.csv
grep -F -eNEW -eUSED Working/Physical-All-Invtory.tmp >>Working/Physical-All-Invtory.csv
$dropbox upload Working/Physical-All-Invtory.csv Invtory/Physical-All-Invtory.csv
##clean up mess at when all done.
rm Working/*.csv
rm Working/*.tmp
