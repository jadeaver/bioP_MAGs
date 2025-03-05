## Overview

GToTree and FastANI were installed via conda and run on a local computer (MacOS).

### GToTree

#### About
[GToTree] (https://github.com/AstrobioMike/GToTree) is a tool used for creating phylogenomic trees. Note, phylogenomic trees use single-copy core genes (SCGs) from genomes, whereas phylogenetic trees use single genes. Either the SCGs or single genes are being used a proxies for estimating organism evolutionary relationships. The Theory behind this describes why genome trees utilize SCGs (instead of all genes). 

#### Resources
This [tutorial] (https://hackmd.io/@AstrobioMike/STAMPS2023-GToTree?utm_source=preview-mode&utm_medium=rec) is very helpful for learning how to use GToTree. And this [usage explanation] (https://github.com/AstrobioMike/GToTree/wiki/example-usage#genomes) is also quite helpful.

#### PAO MAG Trees

##### PAOs in general

I downloaded used the NCBI accession ids from [[Petriglieri-etal-2022.pdf]] as my reference MAGs. I only used the accession ids for the species representatives from Accumulibacter. I included Azonexus genomes as outgroups. I performed the following commands to convert the list of accession ids to the correct format, create a file of my input fasta files (bins 12, 010, and 255), and run GToTree. 

```
csvtk xlsx2csv pao_ref_accessions.xlsx > pao_ref_accessions.csv

csvtk csv2tab pao_ref_accessions.csv > pao_ref_accessions.txt

ls PAO_MAGs/*.fa > fasta-files.txt

GToTree -a pao_ref_accessions.txt -f fasta-files.txt -H Bacteria -D -L Species -j 8 -o pao_tree_output

sed 's|.*/||; s|\.fa$||' fasta-files.txt > MAG_labels.txt

gtt-gen-itol-map -w labels -o iToL-label-colors.txt -g MAG_labels.txt
```

I could (and should) run the Proteobacteria SCG set. `-H Proteobacteria`.
I can also use the `-m` flag to pass labels to the program so I can specify the names. I may want to remove the `-D` and `-L` flags because I don't necessarily want GTDB taxonomy lineages here.

I made a file with new labels for tree ends. I converted it to the correct format with csvtk. 

New GToTree command.

```
GToTree -a pao_ref_accessions.txt -f fasta-files.txt -H Proteobacteria -m tree_labels.txt -j 8 -o pao_tree_output
```

#### Accumulibacter

The same process was used to create the Accumulibacter tree.  Representative species were included in the tree except I replaced Ca. Accumulibacter regalis UW3 with UW4 because UW4 was available on NCBI, but not UW3. I excluded the genome that was not publically available as well. Azonexus genomes were included as outgroups. All 4 Ca. Accumulibacter MAGs identified by GTDB were used in the tree. 

GToTree command:

```
GToTree -f fasta_files.txt -a Species_reps_accessions.txt -H Proteobacteria -D -m genome_to_id_map.tsv -j 4 -o Accumulibacter
```

In iTOL, I modified tree labels to be consistent with the new names provided by [[Petriglieri-etal-2022.pdf]].

*The resulting tree demonstrates that my HQ MAGs are likely Ca. Accumulibacter phosphatis (MAG 010) and Ca. Accumulibacter propinquus (MAG 12), and my MQ MAGs are likely Ca. Accumulibacter conexus (MAG 11) and closely related to Ca. Accumulibacter adjuntus MAG (166)(need to check ANI to this genome). These MAGs represent Clades IIA, IIB, and IIF, respectively*


#### Azonexus

There are 88 representative genomes of Azonexus in GTDB. Tree made with only accessions of GTDB representatives from AS samples or with 90% ANI compared to one of my MAGs.

Followed the Altermonas example, but for Azonexus: https://github.com/AstrobioMike/GToTree/wiki/example-usage#alteromonas-example

My steps:

1. Download accession ids for Azonexus representative species from GTDB
2. Create a directory with my MAGs (and an outgroup MAG). List these files in a file.
3. Create a genome to id map to add new labels to my genomes and the outgroup.
4. Run GToTree with the accession list, fasta files, and mapping file.

```
gtt-get-accessions-from-GTDB -t Azonexus --GTDB-representatives-only

ls My-MAGs/* > fasta_files.txt

cp fasta_files.txt genome_to_id_map.tsv

nano genome_to_id_map.tsv # Edit to add new labels and remove directory

GToTree -f fasta_files.txt -a GTDB-Azonexus-genus-GTDB-rep-accs.txt -H Proteobacteria -m genome_to_id_map.tsv -j 4 -o Azonexus
```

-f the file pointing to my FASTA files
-a the file with the list of reference accession ids
-H the desired HMM profiles to use; will use phylum Proteobacteria because discrepancies in class between GTDB and NCBI (though should be Gammaproteobacteria)
-D will swap input accessions for GTDB taxonomy
-m a mapping file to switch file names with other labels for my MAGs and the outgroup fasta
-j number of threads
-o prefix for outputs


### FastANI

1. Download genomes with ncbi datasets (installed via conda)
2. Make reference and query text files

For Example... 

```
datasets download genome accession --inputfile GTDB-Azonexus-genus-GTDB-rep-accs.txt --include genome

ls genomes/* > ref.txt
ls my_mags/* > query.txt


fastani --ql query.txt --rl ref.txt -o fastani --matrix -t 6
```

