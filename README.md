# Bio-P MAGs Project
Jessica Deaver, Updated: 23 July 2024

The purpose of this project is to recover high quality polyphosphate accumulating organism (PAO) metagenome-assembled genomes (MAGs) from a full-scale biological nutrient removal process. The PAO MAGs will serve as references for further gene expression analysis. 

A brief description of each step is included below. Most bioinformatic analyses were performed on a University HPC Cluster that utilizes an LSF job scheduler. Example scripts used to run each process are included in the 'scripts' folder. 

## Sequencing

Both short and long read sequencing was performed. Short read sequencing was performed on an Illumina NovaSeqX (150-bp PE sequecing). Long read sequencing was performed on a MinION Mk1C device with a R14 FLO-MIN114 flow cell following library preparation with R14 chemistries (SQK-NBD114).

## Quality control & filtering 

Short read sequences were quality checked with FastQC. Samples were already de-multiplexed and there were no adapter sequences and minimal ambiguous bases (0.1% or less in any position). Therefore quality trimming/filtering was deemed unnecessary. 

Long read sequences were basecalled with [Dorado] (https://github.com/nanoporetech/dorado?tab=readme-ov-file) using the super accurate (sup) model. Reads were quality checked with [NanoPlot] (https://github.com/wdecoster/NanoPlot) and filtered with [Filtlong] (https://github.com/rrwick/Filtlong). Reads were filtered to remove those with less than 1500 base pairs and a Q < 7.

## Short read polishing & assembly

The filtered long reads were polished using short reads with [Ratatosk] (https://github.com/DecodeGenetics/Ratatosk), a *de novo* correct tool for long reads that enables accurate assembly. The polished long reads were then assembled using [Flye] (https://github.com/mikolmogorov/Flye) with the `--meta` and `--nano-HQ` options enabled. Each sample read file was assembled individually and all samples were co-assembled. Assemblies statistics were checked with [QUAST] (https://github.com/ablab/quast).

> Co-assembly can improve recovery for less abundant genomes, but introduces a higher chance of strain heterogenity. Therefore, I combined both assembly approaches, and I will dereplicate bins downstream.

## Binning

I mapped both short and long reads to each assembly using [minimap2] (https://github.com/lh3/minimap2). Output SAM files were sorted and converted to BAM files, then indexed with [samtools] (https://www.htslib.org/). Then I merged the long and short read BAM files from the same sample mapped to the same assembly with `samtools merge`. Binning was done using [metabat2] (https://bitbucket.org/berkeleylab/metabat/src/master/) and accounting for differential coverage of the samples to each assembly. Bins across all 9 assemblies were then dereplicated using [dRep] (https://github.com/MrOlm/drep).




