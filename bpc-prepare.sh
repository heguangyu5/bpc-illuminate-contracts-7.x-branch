#!/bin/bash

[[ "$1" == "" ]] && {
    echo "Usage: ./bpc-prepare.sh src.list"
    exit
}

rm -rf ./Illuminate/Contracts/
rsync -a                        \
      --exclude=".*"            \
      -f"- Illuminate/"         \
      -f"+ */"                  \
      -f"- *"                   \
      ./                        \
      ./Illuminate/Contracts/

echo "placeholder-contracts.php" > ./Illuminate/src.list

for i in `cat $1`
do
    if [[ "$i" == \#* ]]
    then
        echo $i
    else
        echo "Contracts/$i" >> ./Illuminate/src.list
        filename=`basename -- $i`
        if [ "${filename##*.}" == "php" ]
        then
            echo "phptobpc $i"
            phptobpc $i > ./Illuminate/Contracts/$i
        else
            echo "cp       $i"
            cp $i ./Illuminate/Contracts/$i
        fi
    fi
done
cp bpc.conf Makefile ./Illuminate/
