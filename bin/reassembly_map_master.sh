##############
# Author: Ben Joris
# Created: July 29th, 2020
# Purpose: Run all scripts required to reassembly and map select samples
##############

mkdir assemblies

./reassembly_assembly_conj.sh

mkdir ../reassembly
cat ../assemblies/*/conj_systems.fasta >> ../reassembly/contigs.fa

mkdir ../reassembly_contigs/
python reassembly_separate_contigs.py

./reassembly_contig_annotation.sh

mkdir ../reassembly_orf_tables/
python reassembly_tabcreate.py

mkdir ../reassembly_operons/
python reassembly_extract_conjugative_elements.py


#### -------- EDIT KAIJU INSTALL LOCATIONS -------- ####
mkdir ../reassembly_taxon/
/Volumes/data/bin/kaiju/bin/kaiju -t /Volumes/data/bin/kaiju/nr/nodes.dmp -f /Volumes/data/bin/kaiju/nr/nr/kaiju_db_nr.fmi -i ../reassembly/contigs.fa -z 5 -o ../reassembly_taxon/tax_contigs.txt
/Volumes/data/bin/kaiju/bin/kaiju-addTaxonNames -t /Volumes/data/bin/kaiju/nr/nodes.dmp -n /Volumes/data/bin/kaiju/nr/names.dmp -i ../reassembly_taxon/tax_contigs.txt -o ../reassembly_taxon/tax_contigs.tsv -r phylum,class
