#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/01.Subsampled_MGs

# For each data file...
for i in $(ls /home/cabana/CABANA/00.Raw_MGs/*.fastq);

  # Gets filename and runs data trough setqk.
  do NAME=$(basename $i .fastq)

  echo "Running seqtk for ${NAME}"
  /home/cabana/tools/seqtk/seqtk sample -s 1000 $i 500000 > $NAME.sub.fastq;

  # Verifies the number of sequences.
  awk 'END {print "The number of sequences is:" NR/4}' $NAME.sub.fastq
  echo "====================================="

done

# Reverts to working dir.
popd