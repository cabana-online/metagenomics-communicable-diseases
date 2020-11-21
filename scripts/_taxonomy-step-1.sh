#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/08.Taxonomy

# Clears the folder before starting work.
rm -rf *

echo "Performing taxonomy. This should take around 45 minutes."
for i in $(ls ../03.CleanLib/*.CoupledReads.fa); do
  NAME=$(basename $i .CoupledReads.fa);
  echo "Metaphlanning $NAME"
  metaphlan2.py ../03.CleanLib/$NAME.CoupledReads.fa --input_type fasta --nproc 4 > ./$NAME_profile.txt;
  echo "Displaying resulting file"
done

popd