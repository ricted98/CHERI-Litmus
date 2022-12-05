#!/bin/bash

if [ "$1" = "" ]; then
  echo "Usage: make-riscv.sh <path-to-litmus-files>"
  exit
fi

sed "25 s/  uint32_t seed = [0-9];/  uint32_t seed = $RANDOM;/" ../main.copy > ../backend/main.c
rm -rf backend-tmp
i=0
j=0

for FILE in $(find $1 -name "*.litmus") #| grep -v "BASIC_2_THREAD\|AMO_X0_2_THREAD")
 do
  # if [ $i -lt 1 ]
  # then
  #FILE="/scratch/msc22h2/CHERI-Litmus/tests/riscv-tests/non-mixed-size/RELAX/Coi-Rfi/MP+fence.rw.rw+ctrl-wsi-rfi-addr.litmus"
  echo "Processing file $FILE"
  cp -r ../backend/ backend-tmp
  if ../frontend/litmus $FILE backend-tmp/testcase.c backend-tmp/testcase.h $2 && ! grep -q P2 $FILE
  then
   cd backend-tmp
   ./make-riscv.sh
   cd ..
   OUTFILE=`basename $FILE .litmus`.elf
   if cp backend-tmp/main.elf $OUTFILE; then
       OUTFILE=`basename $FILE .litmus`.dump
       cp backend-tmp/main.dump $OUTFILE
       rm -rf backend-tmp
       j=$((j+1))
   fi
  # fi
  i=$((i+1))
  fi
  
 done 
 echo "#file well compiled = $j"
 echo "#file analized      = $i"
