#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/02.Quality_Control/step2_Trimmomatic

# Runs the trimmomatic proccess.
echo "Starting trimmomatic process..."
~/scripts/Trimmomatic.sh

# Reverts to working dir.
popd