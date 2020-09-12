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

shell-enveomics :
	@echo "Accessing blast container..."
	docker exec -ti cabana_tutorial_2--enveomics /bin/bash

shell-nonpareil :
	@echo "Accessing nonpareil container..."
	docker exec -ti cabana_tutorial_2--nonpareil /bin/bash

shell-multiqc :
	@echo "Accessing multiqc container..."
	docker exec -ti cabana_tutorial_2--multiqc /bin/bash

shell-seqtk :
	@echo "Accessing multiqc container..."
	docker exec -ti cabana_tutorial_2--seqtk /bin/bash

r :
	@echo "Running R prompt..."
	docker exec -ti cabana_tutorial_2--nonpareil R


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
	docker exec -ti cabana_tutorial_2--nonpareil /bin/bash -c "/home/cabana/scripts/nonpareil.sh"

cv-step-2:
	docker exec -ti cabana_tutorial_2--nonpareil /bin/bash -c "/home/cabana/scripts/r.sh"

prepare-tutorial : download-data uncompress-data seqtk-data

run-quality-control : qc-prepare qc-run-step-1 qc-run-step-2 qc-run-step-3 qc-run-step-4 qc-run-step-5

run-coverage: cv-step-1 cv-step-2

tutorial: prepare-tutorial run-quality-control

