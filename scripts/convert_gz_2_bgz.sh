
find . -name "*.gz" -print0 | while read -d $'\0' file
do
   echo $file
   filename="${file%.*}"
   gzip -d $file
   bgzip $filename
done


