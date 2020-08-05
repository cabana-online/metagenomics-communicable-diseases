#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/02.Quality_Control/step1_FastQC

# Creates the folders.
echo "Starting MulqiQC process..."
multiqc -f .

# Reverts to working dir.
popd