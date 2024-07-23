#!/bin/tcsh

#BSUB -n 1
#BSUB -W 00:45
#BSUB -R span[hosts=1]
#BSUB -J MultiQC
#BSUB -o out.%J
#BSUB -e err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/multiqc-1.21

multiqc 2.0_QC/sortmerna/trial-2/* 3.0_fastp/reports/2A-11-20* 2.0_QC/raw/2A-11-20* 2.0_QC/fastp/2A-11-20* -o 2.1_multiqc -d -dd 1 -v

conda deactivate
