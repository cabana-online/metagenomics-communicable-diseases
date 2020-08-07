#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/02.Quality_Control/step4_FastQ_to_FastA

# For each of the files in the bmtagger output directory...
for result_file in ../step3_BMTagger/output/*.fastq; do

  # Gets current filename and transformed filename.
  fastQFile="$(basename -- $result_file)"
  fastAFile="${fastQFile/fastq/fasta}"

  # Performs conversion
  echo "Transforming ${result_file} to fastA format."
  cat $result_file | paste - - - - | awk 'BEGIN{FS="\t"}{print ">"substr($1,2)"\n"$2}' > $fastAFile

done

# Reverts to working dir.
popd