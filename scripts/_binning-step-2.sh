#!/bin/bash

# Moves to the checkm database directory to download them.
pushd /home/cabana/tools/checkm;

# If both files exist...
if [ ! -d "hmms" ]; then

  echo "Downloading CheckM datasets."
  curl https://data.ace.uq.edu.au/public/CheckM_databases/checkm_data_2015_01_16.tar.gz > checkmdata.tar.gz

  echo "Extracting datasets."
  tar xvzf checkmdata.tar.gz

fi
popd

# Moves to the work directory.
pushd /home/cabana/CABANA/07.Binning

echo "Creating folders for CheckM."
mkdir -p bin output

echo "Copying fasta result files into the bin directory."
cp *.fasta ./bin

echo "Building reference genome tree,"
checkm tree --reduced_tree -x fasta bin output

echo "Finding number of phylogenetically informative marker genes."
checkm tree_qa output

echo "Building marker file on lineage.ms"
checkm lineage_set output lineage.ms

echo "Identifying marker genes with lineage.ms."
checkm analyze -x fasta lineage.ms bin output

echo "Summarizing quality of genome bins."
checkm qa lineage.ms output

echo "Running lineage-specific workflow."
checkm lineage_wf --reduced_tree bin output -x fasta -t 4 --tab_table -f checkM_output.txt

echo "Displaying result contents."
cat checkM_output.txt
sleep 2

echo "Generating plots to assess the quality of the genome bins."
checkm bin_qa_plot output/ bin/ plots -x fasta
echo "Plots created in the \"plots\" folder"
sleep 2
