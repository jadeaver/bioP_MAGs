# Bio-P MAGs Project
Jessica Deaver, Updated: 11 July 2024

The purpose of this project is to recover high quality polyphosphate accumulating organism (PAO) metagenome-assembled genomes (MAGs) from a full-scale biological nutrient removal process. The PAO MAGs will serve as references for further gene expression analysis. 

A brief description of each step is detailed below. Most bioinformatic analyses were performed on a University HPC Cluster that utilizes an LSF job scheduler. Example scripts used to run each process are included in the 'scripts' folder. 

## Sequencing

Both short and long read sequencing was performed. Short read sequencing was performed on an Illumina NovaSeqX (150-bp PE sequecing). Long read sequencing was performed on a MinION Mk1C device with a R14 FLO-MIN114 flow cell following library preparation with R14 chemistries (SQK-NBD114).

## Quality Control and Filtering 

Short read sequences were quality checked with FastQC. Samples were already de-multiplexed and there were no adapter sequences and minimal ambiguous bases (0.1% or less in any position). Therefore quality trimming/filtering was deemed unnecessary. 

Long read sequences were basecalled with [Dorado] (https://github.com/nanoporetech/dorado?tab=readme-ov-file) using the super accurate (sup) model. Reads were quality checked with [NanoPlot] (https://github.com/wdecoster/NanoPlot) and filtered with [Filtlong] (https://github.com/rrwick/Filtlong). Reads were filtered to remove those with less than 1000 base pairs and a Q < 7.

## Assembly

## Short Read polishing 

