#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/02.Quality_Control/step3_BMTagger

# Create the references folder.
if [ ! -d Reference ]; then
  echo "Creating Reference folder."
  mkdir Reference && chmod -R 777 Reference
fi

# Create the output folder used by bmtagger.
if [ ! -d output ]; then
  echo "Creating bmtagger output folder."
  mkdir output && chmod -R 777 output
fi

# Copies the dataset onto the reference folder.
cd Reference
if [ -f /home/cabana/data/hg38.fa ]; then
  mv /home/cabana/data/hg38.fa ./
fi

echo "Running bmtool... (Depending on your system this could take around 60 minutes)"
sleep 3
/home/cabana/tools/bmtagger/bmtool -d hg38.fa -o hg38.bitmask -w 18

echo "=============================================================="
echo "=============================================================="

echo "Running srprism... (Depending on your system this could take around 40 minutes)"
sleep 3
/home/cabana/tools/bmtagger/srprism mkindex -i hg38.fa -o hg38.srprism -M 7168

echo "=============================================================="
echo "=============================================================="

if [ -f hg38.fa ]; then
  echo "Running blast... (Depending on your system, this might take around a minute.)"
  sleep 3
  date
  makeblastdb -in hg38.fa -dbtype nucl
  date

  echo "=============================================================="
  echo "=============================================================="

  echo "Running bmtagger script... (Depending on your system, this might take around a minute.)"
  sleep 3
  date
  ~/scripts/bmtagger.sh
  date

fi

# Reverts to working dir.
popd