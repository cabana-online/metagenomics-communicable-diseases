#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/02.Quality_Control/step3_BMTagger

if [ ! -d tmp ]; then
  mkdir tmp
fi
cd tmp

Input_Directory=/home/cabana/CABANA/02.Quality_Control/step2_Trimmomatic
Output_Directory=/home/cabana/CABANA/02.Quality_Control/step3_BMTagger/output
Reference_Directory=/home/cabana/CABANA/02.Quality_Control/step3_BMTagger/Reference
Temporal_Directory=/home/cabana/CABANA/02.Quality_Control/step3_BMTagger/tmp

cd $Input_Directory

for i in $(ls *.R1.clean.fastq); do

  NAME=$(basename $i .R1.clean.fastq)
  echo "$NAME"
  /home/cabana/tools/bmtagger/bmtagger.sh -b $Reference_Directory/hg38.bitmask -x $Reference_Directory/hg38.srprism -T $Temporal_Directory -q 1 -1 $NAME.R1.clean.fastq -2 $NAME.R2.clean.fastq -o $Output_Directory/$NAME.bmtagger -X ;

done

echo "================================================"
echo "Listing results."
ls
sleep 3

# Reverts to working dir.
popd