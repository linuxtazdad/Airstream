#1/bin/bash
##this is what is going to be for all the sales managers to know what is what.
dropbox="/home/jeremy/.dropscrit/dropbox_uploader.sh"

##download web site invtory
$dropbox download Invtory/Web-site Working/Web-Invtory
##download CDK Raw data
$dropbox download Invtory/CDK-Raw Working/CDK-Raw
##combinding all stors in to one master list.
cat Working/CDK-Raw/ALA.csv >> Working/CDK-All-Store.csv
sed 1d Working/CDK-Raw/AIE.csv >>Working/CDK-All-Store.csv
sed 1d Working/CDK-Raw/AOC.csv >>Working/CDK-All-Store.csv
sed 1d Working/CDK-Raw/ALV.csv >>Working/CDK-All-Store.csv

$drobox upload Working/CDK-All-Store.csv Invtory/CDK-Raw/CDK-All-Store.csv


##clean up mess at when all done.
