#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/02.Quality_Control/step1_FastQC

# Creates the folders.
echo "Starting FASTQ process..."
for FILE in $(ls ../../01.Subsampled_MGs/*.fastq); do

  echo "Running FastQC for $FILE..."
  /home/cabana/tools/fastqc/FastQC/fastqc $FILE --outdir=./
  echo "Completed."
  echo "==================================================="

done

# Reverts to working dir.
popd