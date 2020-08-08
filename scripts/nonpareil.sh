#!/bin/bash

Input_Directory=~/CABANA/02.Quality_Control/step4_FastQ_to_FastA
Output_Directory=~/CABANA/04.Coverage

# Moves to the folder with the fastA files.
cd $Input_Directory

# For each file...
for i in $(ls *.bmtagger_1.fasta); do

  # Gets filename.
  NAME=$(basename $i .bmtagger_1.fasta)
  echo "$NAME"

  # Runs nonpareil with 4 threads
  nonpareil -s $NAME.bmtagger_1.fasta -T alignment -f fasta -b $Output_Directory/$NAME -t 4;

done
