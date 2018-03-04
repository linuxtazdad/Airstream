#//this is just a easy way to get it all taken care of.
alias dropbox="/home/jeremy/.dropscrit/dropbox_uploader.sh"
now=$(date +"%m_%d_%Y")
#no longer needed do to move to dealerspike website 02/2/18
#echo "running  Links.sh"
#./Links.sh
echo "pulling web invtory from dealerspike"
wget -q -O web_invtory.csv "www.airstreamlosangeles.com/feeds.asp?feed=GenericCSVFeed"
echo "getting invtory from dropbox"
/home/jeremy/.dropscrit/./dropbox_uploader.sh download invtory/invtory.csv
echo "comparing the files"
./compare.sh
#echo "uploading web invtory to dropbox"
/home/jeremy/.dropscrit/./dropbox_uploader.sh upload web_invtory.csv invtory/web_invtory.csv
echo "uploading dif stock to dropbox"
/home/jeremy/.dropscrit/./dropbox_uploader.sh upload dif_stock.csv invtory/dif_stock.csv
echo "would be removing files" 
rm dif_stock
rm dif_stock.csv
rm invtory.csv
mv web_invtory.csv WI_$now.csv
#alias dropbox="/home/jeremy/.dropscrit/dropbox_uploader.sh"
