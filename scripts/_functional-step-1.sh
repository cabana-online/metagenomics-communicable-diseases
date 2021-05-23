#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/09.Functional

# Downloads the HUMAnN2 databases.
if [ ! -d "/home/cabana/data/chocophlan" ]; then
  echo "Downloading chocophlan database. This is a 5.37GB dataset. The time it takes to complete depends on your internet connection."
  humann2_databases --download chocophlan full /home/cabana/data
fi

# Downloads the HUMAnN2 databases.
if [ ! -d "/home/cabana/data/uniref" ]; then
  echo "Downloading uniref90_diamond database. This is a 5.87GB dataset. The time it takes to complete depends on your internet connection."
  humann2_databases --download uniref uniref90_diamond /home/cabana/data
fi

# Creates the folder stores the humman2 results.
if [ ! -d "humann2-build" ]; then
  mkdir humann2-build
fi
cd humann2-build

echo "Beginning HUMANn2 process. Depending on your computer this might take up to three hours or more."
sleep 2
for file in $(ls ../../03.CleanLib/*.CoupledReads.fa);do

  # Gets filename and directory location.
  DIR=$(dirname $file)
  NAME=$(basename $file .CoupledReads.fa);

  # Interpose reads.
  echo "====================================="
  echo "Running HUMAnN2 on ${NAME}."
  humann2 --protein-database=/home/cabana/data/uniref --nucleotide-database=/home/cabana/data/chocophlan --input $file --output $NAME --threads 16 --diamond .
  echo " "
  exit

done

popd