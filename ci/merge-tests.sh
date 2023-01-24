#!/bin/bash

dest=run.log
source=./log

rm $dest
touch $dest
i=0
for FILE in $(ls $source) #$(ls log | find ../CHERI-Litmus/tests/riscv-tests/non-mixed-size/ | grep Coi-Rfi)
do 
	#FILE=$(basename $FILE .litmus).log

	#if ! find ../cva6-litmus/tests/riscv-tests/non-mixed-size/ -name "$(basename $FILE .log).litmus" | grep -q HAND; then
		if grep -q Time $source/$FILE; then 
			cat $source/$FILE >> $dest
			echo "" >> $dest
			i=$((i+1))
		else
			echo "'Time' not found in $FILE"
		fi
	#fi

done 
echo "Num of tests = $i"