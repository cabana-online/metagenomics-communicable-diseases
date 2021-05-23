#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/09.Functional

# Creates the folder stores the humman2 joint tables.
if [ ! -d "humann2-processed" ]; then
  mkdir humann2-processed
fi

cd humann2-build
for directory in $(ls ./); do
  pushd $directory

    echo "Gene families for $directory."
    for i in $(ls *_genefamilies.tsv); do
      NAME=$(basename $i _genefamilies.tsv);
      echo "Gene families for $NAME"
      humann2_renorm_table --input ${NAME}_genefamilies.tsv --output ../../humann2-processed/${NAME}_genefamilies_relab.tsv --units relab
    done

    echo "Pathway abundance for $directory."
    for i in $(ls *_pathabundance.tsv); do
      NAME=$(basename $i _pathabundance.tsv);
      echo "Path abundance for $NAME"
      humann2_renorm_table --input ${NAME}_pathabundance.tsv --output ../../humann2-processed/${NAME}_pathabundance_relab.tsv --units relab
    done

  popd

done

# Moves to the processed results folder.
cd ../humann2-processed
echo "Joining tables."
humann2_join_tables --input . --output humann2_genefamilies.tsv --file_name genefamilies_relab
humann2_join_tables --input . --output humann2_pathabundance.tsv --file_name pathabundance_relab

echo "Preparing humann2_pathabundance.tsv for association."
sleep 2

sed -i "s/# Pathway/FEATURE\\SAMPLE/ig" humann2_pathabundance.tsv
sed -i "1 s/.CoupledReads_Abundance//ig" humann2_pathabundance.tsv
sed -i "1a\CLINICAL\tADD\tADD\tADD\tCONTROL\tCONTROL\tCONTROL" humann2_pathabundance.tsv

echo "Running association."
humann2_associate --input humann2_pathabundance.tsv --last-metadatum CLINICAL --focal-metadatum CLINICAL --focal-type categorical --output stats.txt

echo "Plotting significantly differentially abundant pathways."
humann2_barplot --sort sum metadata --input humann2_pathabundance.tsv -f SULFATE-CYS-PWY -o Fig_test_6.png -m CLINICAL -l CLINICAL -d 8 6 -r
location=$(readlink -f Fig_test_6.png)
echo "Plot generated at $location"


popd