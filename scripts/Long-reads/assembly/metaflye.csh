#!/bin/tcsh

#BSUB -n 32
#BSUB -W 1:15
#BSUB -R span[hosts=1]
#BSUB -R select[stc]
#BSUB -J metaflye
#BSUB -o out.%J
#BSUB -e err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/flye-2.9.4

set dir = /share/n2fix/jdeaver/metagenomes/long-read/4.0_filtered-fq

flye --nano-hq $dir/2G_11-20-23.filt.fq.gz $dir/3G_11-20-23.filt.fq.gz --out-dir 5.0_assemblies/dual-assembly/ --meta --threads 32

conda deactivate
