#!/bin/bash

# Moves to the work directory.
pushd /home/cabana/CABANA/08.Taxonomy

# Clears the folder before starting work.
rm -rf *
rm ../03.CleanLib/*bowtie2*

echo "Performing taxonomy. This should take around 45 minutes."
for i in $(ls ../03.CleanLib/*.CoupledReads.fa); do

  # Gets the name of the item to process.
  NAME=$(basename $i .CoupledReads.fa);

  echo "Metaphlanning $NAME"
  metaphlan2.py ../03.CleanLib/$NAME.CoupledReads.fa --input_type fasta --nproc 4 > ./${NAME}_profile.txt;
  echo "Displaying resulting file ${NAME}_profile.txt".
  cat ${NAME}_profile.txt

  echo "Converting to krona format".
  metaphlan2krona.py --profile ${NAME}_profile.txt --krona ./${NAME}_Krona.txt
  echo "Displaying resulting file ${NAME}_Krona.txt".
  cat ${NAME}_Krona.txt

  echo "Generating HTML plot at ${NAME}_Krona.html"
  ktImportText ${NAME}_Krona.txt -o ${NAME}_Krona.html

done

echo "Merging metaphlan into single table."
merge_metaphlan_tables.py *_profile.txt > merged_abundance_table.txt
echo "Displaying resulting table."
cat merged_abundance_table.txt
sleep 2

echo "Generating heatmap."
metaphlan_hclust_heatmap.py --in merged_abundance_table.txt --out metaphlan_hclust --minv 0.3 --top 25 -c hot
echo "Generated image file metaphlan_hclust.png"
sleep 2

popd