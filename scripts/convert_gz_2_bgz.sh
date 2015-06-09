#!/bin/bash

script_name="convert_gz_2_bgz.sh"

if [ -z "$1" ]
  then
    echo "Usage: $script_name [directory with gz files]"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "$script_name: directory $1 not found"
    exit 1
fi

cd $1

find . -name "*.gz" -print0 | while read -d $'\0' file
do
   echo $file
   filename="${file%.*}"
   gzip -d $file
   bgzip $filename
done

cd -

exit $?


