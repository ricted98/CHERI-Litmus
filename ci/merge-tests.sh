#!/bin/bash

dest=litmus.log
source=../hw-results

rm -f $dest
touch $dest
i=0
for FILE in $(ls $source)
do

	#check that the litmus test terminated correctly
	if grep -q Time $source/$FILE; then
		cat $source/$FILE >> $dest
		echo "" >> $dest
		i=$((i+1))
	else
		echo "'Time' not found in $FILE"
	fi


done
echo "Num of tests = $i"