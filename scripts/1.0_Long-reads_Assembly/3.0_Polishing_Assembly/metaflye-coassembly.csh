#!/bin/tcsh

#BSUB -n 32
#BSUB -W 7:00
#BSUB -R span[hosts=1]
#BSUB -R select[stc]
#BSUB -J metaflye
#BSUB -q ccee
#BSUB -o out.%J
#BSUB -e err.%J

# The purpose of this script is to create a co-assembly from polished long reads from all metagenomes

conda activate /usr/local/usrapps/n2fix/jdeaver/flye-2.9.4

set input = "/share/n2fix/jdeaver/metagenomes/long-read/8.0_ratatosk"
set output = "/share/n2fix/jdeaver/metagenomes/long-read/5.0_assemblies/ratatosk/co-assembly"

flye --nano-hq $input/B1_D4_polished.fastq.gz $input/B2_D1_polished.fastq.gz $input/B2_D2_polished.fastq.gz $input/B2_D3_polished.fastq.gz $input/B2_D4_polished.fastq.gz $input/B3_D1_polished.fastq.gz $input/B3_D2_polished.fastq.gz $input/B3_D3_polished.fastq.gz --out-dir $output --meta --threads 32

conda deactivate
