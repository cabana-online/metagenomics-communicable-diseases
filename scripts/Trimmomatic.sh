#!/bin/bash

Input_directory=~/CABANA/01.Subsampled_MGs
Output_directory=~/CABANA/02.Quality_Control/step2_Trimmomatic

cd $Input_directory
ls

for i in $(ls *.R1.sub.fastq); do
  NAME=$(basename $i .R1.sub.fastq)
  echo "$NAME"
  j="${NAME}.R1.sub.fastq"
  echo "$j"
  k="${NAME}.R2.sub.fastq"
  echo "$k"
  java -jar ~/tools/trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 \
    ./$j ./$k \
    $Output_directory/$NAME.R1.clean.fastq $Output_directory/$NAME.R1.unpaired.clean.fastq \
    $Output_directory/$NAME.R2.clean.fastq $Output_directory/$NAME.R2.unpaired.clean.fastq \
    ILLUMINACLIP:/home/cabana/tools/trimmomatic/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10:2:keepBothReads LEADING:3 \
    TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50

done
