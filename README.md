# Supplementary Methods and Materials for the mSystems "Separation of cohorts on the basis of bacterial type IV conjugation systems identified from metagenomic assemblies" paper

## Table of contents

This Readme will have the workflow below the TOC

### Bin
* All scripts used within the project

### Figures
* PDFs of the figures generated and scripts for generating the figures


In this Readme, you will find the workflow necessary for recapitulating the workflow I used to generate the results in the paper. Unfortunately, these methods span back well over a year, and involve a number of disjointed processes, so there is no master script for running the methodology. Additionally, the processes to months to run, so it's probably for the best not to lock your workstation into running this scripts for eternity.

System information:

I ran these processes on a Linux server with an Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz processor and 256GB of RAM.

Run in a conda environment with the following programs installed:
- bowtie2
- anvi'o
- metaSPAdes
- bowtie2
- SRA toolkit
- Trimmomatic
- Prodigal
- Diamond
- metabat2
- checkm
- PlasFlow
- dRep
- MOB suite
- CAT/BAT (with databases installed)

Follow instructions in HMM-information.txt for instructions on how to add HMM profiles for conjugative systems in the anvi'o pipeline.

Installed outside conda environment:
- dedupe (used in scripts for downloading and processing reads, change install location in scripts)
- kaiju (need to edit location of kaiju install and nodes files)

## Step-by-Step Workflow (run from bin folder)

# Section 1: Download reads for assembly

**`pop_mapping_dl.sh` needs to be edited beforehand**

# Section 2: Reassembly of select samples and mapping to conjugative systems

`./reassembly_map_master.sh`
* assembles metagenomes, and predicts conjugative systems, output in `../assemblies/`
* combines all predicted conjugative systems into one file, `../reassembly/contigs.fa`
* separates all contigs into separate fasta files, output in `../reassembly_contigs/`
* ORF prediction and annotation, output in `../reassembly_prodigal_output/` and `../reassembly_diamond_output/`
* `getContigs.py` creates a tsv of the contigs with conjugative systems annotated by UniRef90
* annotation tables with a focus on conjugative protein output to `../reassembly_orf_tables/`

# Section 5: Binning of reassemblies

`./binning_master.sh`
* reads are copied to `../binning/general/reads/` and `../binning/infant/reads/`
* reads are mapped to assemblies from same cohort, sam files are converted to bam files and sorted, output to `../binning/general/mapping/` and `../binning/infant/mapping/`
* binning with metabat2, output in working directory (the bin folder)
* CheckM run to assess bin quality, output in working directory
* evaluate proportions of conjugative systems included in metagenomic bins, output in `../binning_information/`
