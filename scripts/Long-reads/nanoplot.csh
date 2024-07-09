#!/bin/tcsh

#BSUB -n 4
#BSUB -W 00:30
#BSUB -R span[hosts=1]
#BSUB -J NanoPlot
#BSUB -o stdout.%J
#BSUB -e stderr.%J

module load conda

conda activate /usr/local/usrapps/n2fix/jdeaver/NanoPlot 

NanoPlot -t 4 --ubam sup_calls-v2.bam --huge --only-report --info_in_report -o 2.1_QC

conda deactivate
