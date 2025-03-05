#!/bin/tcsh

#BSUB -n 8
#BSUB -W 03:00
#BSUB -R span[hosts=1]
#BSUB -J FastQC
#BSUB -o out.%J
#BSUB -e err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/fastqc-0.12.1

fastqc -t 8 -o 2.0_QC/fastp 3.0_fastp/*.fastq.gz

conda deactivate
