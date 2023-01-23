#!/bin/bash

dest=/usr/scratch/badile30/msc22h2/cva6_forked/run.log

rm -rf $dest
touch $dest
i=0
for FILE in $(ls log) #$(ls log | find ../CHERI-Litmus/tests/riscv-tests/non-mixed-size/ | grep Coi-Rfi)
do 
	#FILE=$(basename $FILE .litmus).log

	#if ! find ../cva6-litmus/tests/riscv-tests/non-mixed-size/ -name "$(basename $FILE .log).litmus" | grep -q HAND; then
		if grep -q Time log/$FILE; then 
			cat log/$FILE >> $dest
			echo "" >> $dest
			i=$((i+1))
		else
			echo "'Time' not found in $FILE"
		fi
	#fi

done 
echo "Num of tests = $i"