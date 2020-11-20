#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/05.Mash

echo "Preparing data with mash."
for i in ../03.CleanLib/*CoupledReads.fa; do
  mash sketch $i -o ./$(basename $i .CoupledReads.fa) -k 25 -s 100000;
done

echo "Estimates pairwise distance with the bash script."
bash /home/cabana/scripts/dist_mash.bash
echo "Estimation complete."

echo "Listing generated files."
ls
sleep 3

echo "Concatenating output files into mash.distances.txt"
cat *.dist > mash.distances.txt
echo "Concatenation complete."

echo "Removing extensions from generated file."
sed -i 's/.CoupledReads.fasta//g' mash.distances.txt
sed -i 's/.CoupledReads.fa//g' mash.distances.txt
sed -i 's/03.CleanLib\///g' mash.distances.txt
sed -i 's/\.\.\///g' mash.distances.txt
echo "Extensions removed."
echo "Estimations:"
cat mash.distances.txt
sleep 3

echo "Preparing data for R".
awk '{ print $1, $2, $3 }' mash.distances.txt > mash.distances.final.txt
echo "Completed."
cat mash.distances.final.txt
sleep 3