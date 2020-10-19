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
FILE_CHECKSUM=8e8ae3f73d61c3ec8c2477334199557128946276
DO_DOWNLOAD=1

# Loops until file is properly downloaded.
while [[ $DO_DOWNLOAD = 1 ]]; do

  # Checks if file exists.
  if [[ -f "$FILE" ]]; then
    echo "$FILE already present. Checking file integrity..."
    DOWNLOAD_CHECKSUM=`sha1sum $FILE`
    if [[ $DOWNLOAD_CHECKSUM = $FILE_CHECKSUM* ]]; then
      echo "File integrity correct. Using existing file."
      DO_DOWNLOAD=0
    else
      echo "File integrity failed. It must be redownloaded."
    fi
  fi

  # Downloads file if required.
  if [[ $DO_DOWNLOAD = 1 ]]; then
    echo "Downloading dataset hg38.fa.gz... (Depending on your internet connection this could take around 60 minutes)."
    sleep 3
    curl http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz > hg38.fa.gz
  fi

done
