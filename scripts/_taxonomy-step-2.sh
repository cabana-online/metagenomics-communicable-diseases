#!/bin/bash

echo "Running STAMP."
echo "This section of the tutorial requires you to use the GUI to manually replicate the steps defined in the document."
echo "* Profile file to use is located at \"/home/cabana/CABANA/08.Taxonomy\merged_metaphlan2_tables.spf".
echo "* Profile file to use is located at \"/home/cabana/data/mapFile.txt".
echo ""
echo "Once you finish this, the automatic execution will resume."
sleep 5
xhost +localhost && docker exec -i -e DISPLAY cabana_tutorial_2--stamp STAMP
