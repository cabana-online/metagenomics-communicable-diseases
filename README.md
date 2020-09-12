# Metagenomics in Communicable Diseases: Tutorial #2

## Metagenomics for the Study of Human Gut Microbiome in Health and Disease: Applications in Acute Diarrheal Diseases (ADD)

## Authors

* Angela Peña-González, PhD
* Alejandro Reyes Muñoz, PhD

School of Biological Sciences, Universidad de los Andes

## Description

This repository provides assistance for the student to complete *Metagenomics in Communicable Diseases: Tutorial #2*, by
providing an already configured environment, allowing the student to focus on using the tools used throughout the
document.

### Requisites 

* Linux or OSX is advised as the environment to run this tutorial on. The following is a list of alternatives you could
use if you don't have access to one of those environments.
  * On Windows using a virtual machine solution ([VirtualBox](https://www.virtualbox.org/) or [VMware](https://my.vmware.com/en/web/vmware/downloads/free#desktop_end_user_computing/vmware_workstation_player/15_0) should do it) with a Linux install.
  * Acquiring an [AWS](https://aws.amazon.com/ec2/) instance (depending on setup could be free or incur in a monthly fee).
  * Acquiring a [Google compute engine](https://cloud.google.com/compute) instance (depending on setup could be free or incur in a monthly fee).
  * Acquiring an [Azure Virtual Machine](https://azure.microsoft.com/en-us/services/virtual-machines/) instance (depending on setup could be free or incur in a monthly fee).
* [Docker](https://docs.docker.com/get-docker/) must be installed on the environment.
* [Docker Compose](https://docs.docker.com/compose/install/) must be installed on the environment.
* [Make](https://man7.org/linux/man-pages/man1/make.1.html) must be installed on the environment. 

### Commands

These must be run on the project folder. These commands depend on `make` being available.

#### General commands

* `make start` - Will download (if not available) the docker images and start the docker containers neccessary to run
the tutorial.
* `make stop` - If the containers are running, it will shut them down.
* `make tutorial` - If the containers are running, it will replicate the steps described in the tutorial file and store
the results on the `CABANA` folder as described. 

#### Specific commands

* `make prepare-tutorial` - Will perform data preparation by downloading datasets used for control and testing.
  * `make download-data` - Downloads data that will be used on the tutorial.
  * `make uncompress-data` - Uncompresses the compressed datasets downloaded with the above command.
  * `make seqtk-data` - Takes the uncompressed data and pass it through seqtk.
* `make run-quality-control` - Runs the quality control steps from the tutorial.
  * `make qc-prepare` - Prepares the seqtk data for the quality control process.
  * `make qc-run-step-1` - Quality control step 1 from the tutorial.
  * `make qc-run-step-2` - Quality control step 2 from the tutorial.
  * `make qc-run-step-3` - Quality control step 3 from the tutorial.
  * `make qc-run-step-4` - Quality control step 4 from the tutorial.
  * `make qc-run-step-5` - Quality control step 5 from the tutorial.
* `make run-coverage` - Runs the coverage steps from the tutorial.
  * `make cv-step-1` - Coverage step 1 from the tutorial.
  * `make cv-step-2` - Coverage step 1 from the tutorial.

#### Container shell access.

In order to ease the access to the containers the following commands were created.
* `make shell-blast` - Shell access to the blast container.
* `make shell-bmtagger` - Shell access ot the bmtagger container.
* `make shell-enveomics` - Shell access to the enveomics container.
* `make shell-nonpareil` - Shell access to the R with nonpareil container.
* `make shell-multiqc` - Shell access to the multiqc container.
* `make shell-seqtk` - Shell access to the seqtk container.

### Repository structure  

* The `CABANA` folder will contain the resulting files from the different steps.
* The `DATA` folder will contain some datasets downloaded from some tools.
* The `scripts` folder will contain bash scripts that will be executed by the different docker containers in order to 
implement the same steps defined in the tutorial.
  
### Notes

* At least 110GB of available hard drive space (docker images, data sets).
* At least 8GB of RAM on the environment where the tutorial will run.
* The tasks must download data from different sources. Because of this, the time to complete some steps will depend on
network connection speed.
* The datasets are quite large. Because of this, the time to complete some tasks depends on the CPU and the
available amount of RAM.
* The average time to run the tutorial on a 100/100 MB optic fiber network, and a Lubuntu VMware instance running on
Windows with 16GB of RAM assign and 3 cores of an Intel i7-9750CPU was 3 hours during a clean run (data downloaded for
the first time).
* The average time to run the tutorial on a 100/100 MB optic fiber network, and a Lubuntu VMware instance running on
Windows with 16GB of RAM assign and 3 cores of an Intel i7-9750CPU was 1 hours during a subsequent run (no data download).

### Download size

Data download over a 100/100 MB network.

| Data file | Download time | Data size |
|---|---|---|
| SRR8555090 - 1 | 0:03:11 | 544MB |
| SRR8555090 - 2 | 0:03:33 | 570MB |
| SRR8555091 - 1 | 0:04:24 | 660MB |
| SRR8555091 - 2 | 0:04:49 | 683MB |
| SRR9988196 - 1 | 0:03:46 | 610MB |
| SRR9988196 - 2 | 0:03:23 | 625MB |
| SRR9988190 - 1 | 0:01:14 | 90.9MB |
| SRR9988190 - 2 | 0:01:16 | 94.1MB |
| SRR9988205 - 1 | 0:08:12 | 615MB |
| SRR9988205 - 2 | 0:04:09 | 630MB |
| SRR8555113 - 1 | 0:14:53 | 730MB |
| SRR8555113 - 2 | 0:03:28 | 751MB |

## Contact

Feel free to add issue in case something is not working for you as intended.