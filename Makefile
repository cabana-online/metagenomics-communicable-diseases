.PHONY : build start stop shell download-data decompress-data fastq-data prepare-tutorial

build :
	docker build -t cabana-base

start :
	@echo "Starting up containers for Cabana Tutorial 2..."
	docker-compose pull
	docker-compose up -d --remove-orphans

stop :
	@echo "Stopping up containers for Cabana Tutorial 2..."
	docker-compose down

shell-blast :
	@echo "Accessing blast container..."
	docker exec -ti cabana_tutorial_2--blastz /bin/bash

shell-bmtagger :
	@echo "Accessing runtime container..."
	docker exec -ti cabana_tutorial_2--bmtagger /bin/bash

shell-checkm :
	@echo "Accessing checkm container..."
	docker exec -ti cabana_tutorial_2--checkm /bin/bash

shell-enveomics :
	@echo "Accessing blast container..."
	docker exec -ti cabana_tutorial_2--enveomics /bin/bash

shell-mash :
	@echo "Accessing mash container..."
	docker exec -ti cabana_tutorial_2--mash /bin/bash

shell-maxbin2 :
	@echo "Accessing mash container..."
	docker exec -ti cabana_tutorial_2--maxbin2 /bin/bash

shell-megahit :
	@echo "Accessing megahit container..."
	docker exec -ti cabana_tutorial_2--megahit /bin/bash

shell-metaphlan2 :
	@echo "Accessing metaphlan2 container..."
	docker exec -ti cabana_tutorial_2--metaphlan2 /bin/bash

shell-multiqc :
	@echo "Accessing multiqc container..."
	docker exec -ti cabana_tutorial_2--multiqc /bin/bash

shell-r :
	@echo "Accessing r container..."
	docker exec -ti cabana_tutorial_2--r /bin/bash

shell-seqtk :
	@echo "Accessing multiqc container..."
	docker exec -ti cabana_tutorial_2--seqtk /bin/bash

shell-stamp :
	@echo "Accessing stamp container..."
	docker exec -ti cabana_tutorial_2--stamp /bin/bash

r :
	@echo "Running R prompt..."
	docker exec -ti cabana_tutorial_2--r R

download-data :
	docker exec -ti cabana_tutorial_2--enveomics /bin/bash -c "/home/cabana/scripts/_download-metagenomic-libraries.sh"

uncompress-data :
	docker exec -ti cabana_tutorial_2--enveomics /bin/bash -c "/home/cabana/scripts/_uncompress_metagemonic-libraries.sh"

seqtk-data :
	docker exec -ti cabana_tutorial_2--seqtk /bin/bash -c "/home/cabana/scripts/_seqtk-data-libraries.sh"

qc-prepare:
	docker exec -ti cabana_tutorial_2--seqtk /bin/bash -c "/home/cabana/scripts/_quality-control--prepare.sh"

qc-run-step-1:
	docker exec -ti cabana_tutorial_2--fastqc /bin/bash -c "/home/cabana/scripts/_quality-control--step-1--fastqc.sh"
	docker exec -ti cabana_tutorial_2--multiqc /bin/bash -c "/home/cabana/scripts/_quality-control--step-1--multiqc.sh"

qc-run-step-2:
	docker exec -ti cabana_tutorial_2--trimmomatic /bin/bash -c "/home/cabana/scripts/_quality-control--step-2.sh"

qc-run-step-3:
	docker exec -ti cabana_tutorial_2--bmtagger /bin/bash -c "/home/cabana/scripts/_quality-control--step-3.sh"

qc-run-step-4:
	docker exec -ti cabana_tutorial_2--bmtagger /bin/bash -c "/home/cabana/scripts/_quality-control--step-4.sh"

qc-run-step-5:
	docker exec -ti cabana_tutorial_2--enveomics /bin/bash -c "/home/cabana/scripts/_quality-control--step-5.sh"

cv-step-1:
	docker exec -ti cabana_tutorial_2--r /bin/bash -c "/home/cabana/scripts/nonpareil.sh"

cv-step-2:
	docker exec -ti cabana_tutorial_2--r /bin/bash -c "/home/cabana/scripts/r.sh"

distance-estimation-step-1:
	docker exec -ti cabana_tutorial_2--mash /bin/bash -c "/home/cabana/scripts/_distance-estimation-1.sh"

distance-estimation-step-2:
	docker exec -ti cabana_tutorial_2--r /bin/bash -c "/home/cabana/scripts/_distance-estimation-2.sh"

metagenomic-assembly-step-1:
	docker exec -ti cabana_tutorial_2--megahit /bin/bash -c "/home/cabana/scripts/_metagenomic-assembly-1.sh"

binning-step-1:
	docker exec -ti cabana_tutorial_2--maxbin2 /bin/bash -c "/home/cabana/scripts/_binning-step-1.sh"

binning-step-2:
	docker exec -ti cabana_tutorial_2--checkm /bin/bash -c "/home/cabana/scripts/_binning-step-2.sh"

taxonomy-step-1:
	docker exec -ti cabana_tutorial_2--metaphlan2 /bin/bash -c "/home/cabana/scripts/_taxonomy-step-1.sh"

taxonomy-step-2:
	scripts/_taxonomy-step-2.sh

functional:
	echo "Thank you"


prepare-tutorial : download-data uncompress-data seqtk-data

run-quality-control : qc-prepare qc-run-step-1 qc-run-step-2 qc-run-step-3 qc-run-step-4 qc-run-step-5

run-coverage: cv-step-1 cv-step-2

run-distance-estimation: distance-estimation-step-1 distance-estimation-step-2

run-metagenomic-assembly: metagenomic-assembly-step-1

run-binning-clustering: binning-step-1 binning-step-2

run-taxonomy: taxonomy-step-1 taxonomy-step-2

run-functional: functional

tutorial: prepare-tutorial run-quality-control run-coverage run-distance-estimation run-metagenomic-assembly run-binning-clustering run-taxonomy

