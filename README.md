# Bio-P MAGs Project
Jessica Deaver, Updated: 27 September 2024

The purpose of this project is to recover high quality polyphosphate accumulating organism (PAO) metagenome-assembled genomes (MAGs) from a full-scale biological nutrient removal process. 

A brief description of each step is included below. Most bioinformatic analyses were performed on a University HPC Cluster that utilizes an LSF job scheduler. Example scripts used to run each process are included in the 'scripts' folder.

## Sequencing

Both short and long read sequencing was performed. Short read sequencing was performed on an Illumina NovaSeqX (150-bp PE sequecing). Long read sequencing was performed on a MinION Mk1C device with a R14 FLO-MIN114 flow cell following library preparation with R14 chemistries (SQK-NBD114).

## Quality control & filtering 

Short read sequences were quality checked with FastQC. Samples were already de-multiplexed and there were no adapter sequences and minimal ambiguous bases (0.1% or less in any position). Therefore quality trimming/filtering was deemed unnecessary. 

Long read sequences were basecalled with [Dorado] (https://github.com/nanoporetech/dorado?tab=readme-ov-file) using the super accurate (sup) model. Reads were quality checked with [NanoPlot] (https://github.com/wdecoster/NanoPlot) and filtered with [Filtlong] (https://github.com/rrwick/Filtlong). Reads were filtered to remove those with less than 1500 base pairs and a Q < 7.

## Short read polishing & assembly

The filtered long reads were polished using short reads with [Ratatosk] (https://github.com/DecodeGenetics/Ratatosk), a *de novo* correction tool for long reads that enables accurate assembly. The polished long reads were then assembled using [Flye] (https://github.com/mikolmogorov/Flye) with the `--meta` and `--nano-HQ` options enabled. Each sample was assembled individually, samples from the same day were co-assembled, and all eight samples were co-assembled for a total of 13 assemblies. Assemblies statistics were checked with [QUAST] (https://github.com/ablab/quast).

> Co-assembly can improve recovery for less abundant genomes, but introduces a higher chance of strain heterogenity. Therefore, I combined both assembly approaches, and dereplicated bins downstream.

## Binning

I mapped both short and long reads to each assembly using [minimap2] (https://github.com/lh3/minimap2). Output SAM files were sorted and converted to BAM files, then indexed with [samtools] (https://www.htslib.org/). Then I merged the long and short read BAM files from the same sample mapped to the same assembly with `samtools merge`. Binning was done using both [metabat2] (https://bitbucket.org/berkeleylab/metabat/src/master/) and [maxbin2] (https://sourceforge.net/projects/maxbin2/files/). Differential coverage of all samples to each assembly was considered for both binning methods. Bins created from the SAME assembly using either metabat2 or maxbin2 were dereplicated using [DasTool] (https://github.com/cmks/DAS_Tool). The best representative bins across all assemblies were selected using [dRep] (https://github.com/MrOlm/drep) to either a 98% average nucleotide identity (ANI) or 95% ANI (approximately species-level).

## Bin Assessment

The depreplicated, best representative bins were evaluated with [checkM] (https://ecogenomics.github.io/CheckM/) and assigned taxonomy based on GTDB classifications. I ran the `classify_wf` included in [GTDB-Tk] (https://ecogenomics.github.io/GTDBTk/commands/classify_wf.html). Bins identified as known PAOs or tentative PAOs (based on NCBI taxonomy of the closest reference genome) were selected for further investigation. There were 8 total bins, 4 with completion > 90% and redundancy < 5%, and 4 with completion > 75% and redundancy < 5%. These bins were visualised with [Anvi'o] (https://anvio.org/) to confirm even coverage. 

[CoverM] (https://wwood.github.io/CoverM/coverm-genome.html#coverage-calculation-options) was used to estimate coverage and relative abundance of all dereplicated bins and the unmapped read percentage using short reads mapped to the MAGs.


## Draft genome annotation

I annotated the draft genomes with [bakta] (https://bakta.readthedocs.io/en/latest/index.html). One goal was to identify the rRNA and tRNA genes present because [MIMAG standards] (https://www.nature.com/articles/nbt.3893) specify that high quality draft genomes have 5S, 23S, and 16S rRNA and > 18 tRNA genes present. The four highest completion tentative PAO bins met these requirements to be considered high-quality draft genomes. The rRNA genes were missing in 2/4 of the lower completion draft genomes. All 4 of those genomes are still considered medium-quality draft genomes.





