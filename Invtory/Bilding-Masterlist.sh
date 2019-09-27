#1/bin/bash
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
##gets bash to ignore white space
#IFS=$'\n'
sed 1d Working/CDK-All-Store.csv| sponge Working/CDK-All-Store.csv
tr ' ' '_' <Working/CDK-All-Store.csv|sponge Working/CDK-All-Store.csv
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
  SALE_PRICE=$(echo $i |cut -d ',' -f12|tr -d '[:space:]')
  MSRP=$(echo $i |cut -d ',' -f30)
  INVOICE=$(echo $i |cut -d ',' -f13|tr -d '[:space:]')
  BALANCE=$(echo $i |cut -d ',' -f14|tr -d '[:space:]')
  COMPANY_NUMBER=$(echo $i |cut -d ',' -f16|tr -d '[:space:]')
  AGE=$(echo $i |cut -d ',' -f17|tr -d '[:space:]')
  DEALER_NOTES=$(echo $i |cut -d ',' -f23|tr -d '[:space:]')
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
  esac
echo $STOCK_NUMBER,$STOCK_TYPE,$MODEL_YEAR,$MAKE,$MODEL,$MODEL_NUMBER,$OUTSIDE_COLOR,$INSIDE_COLOR,$AGE,$MSRP,$SALE_PRICE,$BALANCE,$INVOICE,$LOCATED,$VIN_NUMBER,$DEALER_NOTES,>>Working/Managers-Invtory.tmp
done
echo "stock No,Type,Year,Make,Model,Model#,ExtColor,IntColor,Age,MSRP,SalePrice,Balance,Invoice,LOT,VIN,Notes," >Working/Managers-Invtory.csv
cat Working/Managers-Invtory.tmp >>Working/Managers-Invtory.csv
$dropbox upload Working/Managers-Invtory.csv Invtory/Managers-Invtory.csv
##clean up mess at when all done.
rm Working/CDK-All-Store.csv
rm Working/Managers-Invtory.tmp
rm Working/Managers-Invtory.csv
