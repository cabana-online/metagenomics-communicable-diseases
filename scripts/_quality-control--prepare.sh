#!/bin/bash

# Moves to the work directory.
cd ~/CABANA/02.Quality_Control

# Creates the folders.
echo "Creating work folders..."
mkdir step1_FastQC step2_Trimmomatic step3_BMTagger step4_FastQ_to_FastA step5_Interpose_PE_reads

# Lists folders.
echo "Folders created. List: "
ls -l

# Changes to the new working directory.
cd ~/data

# Downloads required data.
FILE=hg38.fa.gz
if [[ -f "$FILE" ]]; then
    echo "$FILE already present skipping download.."
else
  echo "Downloading dataset hg38.fa... (Depending on your internet connection this could take around 60 minutes)."
  sleep 3
  curl http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz > hg38.fa.gz
fi

FILE=hg38.fa
if [[ -f "$FILE" ]]; then
    echo "$FILE already decompressed. Skipping step.."
else
  echo "Decompressing dataset hg38.fa... (Depending on your system this could take around 5 minutes)."
  sleep 3
  gunzip -k hg38.fa.gz
fi
