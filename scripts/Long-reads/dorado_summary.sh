#!/bin/bash

#BSUB -n 1
#BSUB -W 30
#BSUB -J dorado_summary
#BSUB -R "span[hosts=1]"
#BSUB -o dorsum_out.%J
#BSUB -e dorsum_err.%J

/usr/local/usrapps/n2fix/jdeaver/dorado-0.6.2-linux-x64/bin/dorado summary sup_calls.bam > sequancing_summary.txt

