#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/05.Mash

echo "Creating mapFile.txt"
echo "Library	Condition" > mapFile.txt
echo "MG24	ADD" >> mapFile.txt
echo "MG29	ADD" >> mapFile.txt
echo "MG32	ADD" >> mapFile.txt
echo "MG44	CONTROL" >> mapFile.txt
echo "MG73	CONTROL" >> mapFile.txt
echo "MG52	CONTROL" >> mapFile.txt
echo "File created."
cat mapFile.txt

# Runs the R script.
echo "Running R distance estimation script."
R --file=/home/cabana/scripts/distance.r --slave
