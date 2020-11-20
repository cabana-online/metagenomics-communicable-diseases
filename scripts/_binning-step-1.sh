#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/07.Binning

# Clears the folder before starting work.
rm *

echo "Performing binning. This should take around 45 minutes."
for i in $(ls ../03.CleanLib/*.CoupledReads.fa); do
  NAME=$(basename $i .CoupledReads.fa);
  run_MaxBin.pl -contig ../06.Assembly/$NAME/$NAME.contigs.fa -reads  ../03.CleanLib/$NAME.CoupledReads.fa -out $NAME -thread 4 -plotmarker;
done
echo "Result files:"
ls
sleep 2
