#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/02.Quality_Control/step5_Interpose_PE_reads

for i in $(ls ../step4_FastQ_to_FastA/*.bmtagger_1.fasta);do

  # Gets filename and directory location.
  DIR=$(dirname $i)
  NAME=$(basename $i .bmtagger_1.fasta);

  # Interpose reads.
  echo "Interposing reads for ${NAME}."
  /home/cabana/tools/enveomics/Scripts/FastA.interpose.pl $NAME.CoupledReads.fa $DIR/$NAME.bmtagger_1.fasta $DIR/$NAME.bmtagger_2.fasta;

done

# Copies the clean sets for further processing.
echo "Copying clean sets to clean library folder."
cp *.CoupledReads.fa ../../03.CleanLib/

# Reverts to working dir.
popd