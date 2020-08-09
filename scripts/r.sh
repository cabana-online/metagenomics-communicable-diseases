#!/bin/bash

# Moves to the coverage folder.
cd /home/cabana/CABANA/04.Coverage

# Runs the R script.
echo "Running R script."
R --file=/home/cabana/scripts/coverage.r --slave

