#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/09.Functional

for directory in $(ls ./); do
  pushd $directory

  echo "Gene families for $directory."
  for i in $(ls *_genefamilies.tsv); do
    NAME=$(basename $i _genefamilies.tsv);
    echo "Gene families for $NAME"
    humann2_renorm_table --input ${NAME}_genefamilies.tsv --output ${NAME}_genefamilies_relab.tsv --units relab
  done

  echo "Pathway abundance for $directory."
  for i in $(ls *_pathabundance.tsv); do
    NAME=$(basename $i _pathabundance.tsv);
    echo "Path abundance for $NAME"
    humann2_renorm_table --input ${NAME}_pathabundance.tsv --output ${NAME}_pathabundance_relab.tsv --units relab
  done

  echo "Joining tables."
  humann2_join_tables --input . --output humann2_genefamilies.tsv --file_name genefamilies_relab
  humann2_join_tables --input . --output humann2_pathabundance.tsv --file_name pathabundance_relab

  popd
done

popd