#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/06.Assembly

echo "Performing binning. This should take around 45 minutes."
for i in $(ls ../03.CleanLib/*.CoupledReads.fa); do
  NAME=$(basename $i .CoupledReads.fasta);
  run_MaxBin.pl -contig ../06.Assembly/$NAME.contigs.fa -reads  ../03.CleanLib/$NAME.CoupledReads.fasta -out $NAME -thread 4 -plotmarker;
done
ls