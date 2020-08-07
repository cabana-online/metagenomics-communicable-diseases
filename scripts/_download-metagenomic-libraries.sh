#!/bin/bash

cd /home/cabana/CABANA

# Creates work directories.
mkdir -p \
    00.Raw_MGs \
    01.Subsampled_MGs \
    02.Quality_Control \
    03.CleanLib \
    04.Coverage \
    05.Mash \
    06.Assembly \
    07.Binning \
    08.Taxonomy \
    09.Functional;

# Changes to our first working directory.
cd 00.Raw_MGs

# Libraries to download.
declare -A files=(
  [SRR9988196]=MG24_ADD
  [SRR9988205]=MG29_ADD
  [SRR9988190]=MG32_ADD
  [SRR8555090]=MG44_CTL
  [SRR8555113]=MG73_CTL
  [SRR8555091]=MG52_CTL
)

declare -A checksums=(
  ["MG24_ADD/SRR9988196/SRR9988196_1.fastq.gz"]=b0af5e3ad5f81c119c19c623c5e16a548f4b17c1
  ["MG24_ADD/SRR9988196/SRR9988196_2.fastq.gz"]=3b6504bb36633a10bf9b4a8d9c89c64c76629a93
  ["MG29_ADD/SRR9988205/SRR9988205_1.fastq.gz"]=8cf3b28ccaccd07f7687615c146f723ce383b86c
  ["MG29_ADD/SRR9988205/SRR9988205_2.fastq.gz"]=253a5b256bed2d79314686e3e8128976ac638bba
  ["MG32_ADD/SRR9988190/SRR9988190_1.fastq.gz"]=8a25c991b41896c384386e79f3354929a26c46b1
  ["MG32_ADD/SRR9988190/SRR9988190_2.fastq.gz"]=d790b15c3c072203dfa726b1f9b9e9cf8231dcbb
  ["MG44_CTL/SRR8555090/SRR8555090_1.fastq.gz"]=af815496dbe2ad5722d5dcb648fd42f249ef655a
  ["MG44_CTL/SRR8555090/SRR8555090_2.fastq.gz"]=ebaf730ca67a9a588950cd305369d5448010401e
  ["MG73_CTL/SRR8555113/SRR8555113_1.fastq.gz"]=f975c85e7f732190511b611a65d6d34bb0341a77
  ["MG73_CTL/SRR8555113/SRR8555113_2.fastq.gz"]=20e75e6f5c5afd469b3eeb8650fda76cd4642d87
  ["MG52_CTL/SRR8555091/SRR8555091_1.fastq.gz"]=f101c9364ec6f47638f0ca093a1bd6e69cf94171
  ["MG52_CTL/SRR8555091/SRR8555091_2.fastq.gz"]=2b05679365f0b958585d0d982407ed99a270ca8e
)

# Downloads each file and moves it to the corresponding folder.
for i in "${!files[@]}"
do

  echo "Starting download for $i ${files[$i]}."

  file1=${files[$i]}/$i/${i}_1.fastq.gz
  file2=${files[$i]}/$i/${i}_2.fastq.gz
  file1_sum=${checksums[$file1]}
  file2_sum=${checksums[$file2]}

  # If both files exist...
  if [ -f "$file1" ] && [ -f "$file2" ]; then

    # Notifies user.
    echo "Files ${file1} and ${file2} already present. Checking files integrity..."
    checksum1=`sha1sum $file1`
    checksum2=`sha1sum $file2`

    if [[ $checksum1 = $file1_sum* ]] && [[ $checksum2 = $file2_sum* ]]; then

      echo "Files integrity match. Skipping file download for ${file1} and ${file2}."

    else

      echo "Files integrity mismatch. Re-downloading files ${file1} and ${file2}."
      /home/cabana/tools/enveomics/Scripts/SRA.download.bash $i ${files[$i]}
      echo "Download completed."

    fi

  else

    echo "Files not present. Downloading files ${file1} and ${file2}."
    /home/cabana/tools/enveomics/Scripts/SRA.download.bash $i ${files[$i]}
    echo "Download completed."

  fi

  echo "Copying and renaming data files."

  # Split folder name by underscore, so that we can get the filename without the information type used.
  IFS='_'
  read -ra NAME <<< ${files[$i]}
  IFS=' '

  # Moves files to the work folder.
  cp $file1 ${NAME[0]}.R1.fastq.gz
  cp $file2 ${NAME[0]}.R2.fastq.gz

  echo "Completed process for $i ${files[$i]}."
  echo "============================================"

done
