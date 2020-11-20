#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/06.Assembly

echo "Performing assembly. This should take around 45 minutes."
for i in $(ls ../03.CleanLib/*.CoupledReads.fa); do
  megahit --12 $i -t 4  --out-prefix $(basename $i .CoupledReads.fa) --min-contig-len 500 -o ./$(basename $i .CoupledReads.fa);
done
ls