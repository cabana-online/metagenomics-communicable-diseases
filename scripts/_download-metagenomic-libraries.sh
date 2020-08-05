#!/bin/bash

# Libraries to download.
declare -A files=(
  [SRR9988196]=MG24_ADD
  [SRR9988205]=MG29_ADD
  [SRR9988190]=MG32_ADD
  [SRR8555090]=MG44_CTL
  [SRR8555113]=MG73_CTL
  [SRR8555091]=MG52_CTL
)

# Creates work directories.
mkdir -p \
    /home/cabana/CABANA/00.Raw_MGs \
    /home/cabana/CABANA/01.Subsampled_MGs \
    /home/cabana/CABANA/02.Quality_Control \
    /home/cabana/CABANA/03.CleanLib \
    /home/cabana/CABANA/04.Coverage \
    /home/cabana/CABANA/05.Mash \
    /home/cabana/CABANA/06.Assembly \
    /home/cabana/CABANA/07.Binning \
    /home/cabana/CABANA/08.Taxonomy \
    /home/cabana/CABANA/09.Functional;

# Changes to our first working directory.
cd /home/cabana/CABANA/00.Raw_MGs

# Downloads each file and moves it to the corresponding folder.
for i in "${!files[@]}"
do

  echo "Starting download for $i ${files[$i]}."
  /home/cabana/tools/enveomics/Scripts/SRA.download.bash $i ${files[$i]}
  echo "Download completed. Renaming and moving files."

  # Split filename.
  IFS='_'
  read -ra NAME <<< ${files[$i]}
  IFS=' '

  # Moves files to the work folder.
  cp ${files[$i]}/$i/${i}_1.fastq.gz ${NAME[0]}.R1.fastq.gz
  cp ${files[$i]}/$i/${i}_2.fastq.gz ${NAME[0]}.R2.fastq.gz

  echo "Completed process for $i ${files[$i]}."
  echo "============================================"

done
