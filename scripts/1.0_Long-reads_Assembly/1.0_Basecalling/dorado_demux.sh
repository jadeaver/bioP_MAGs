#!/bin/bash

#BSUB -n 1
#BSUB -W 60
#BSUB -J dorado_demux
#BSUB -R "span[hosts=1]"
#BSUB -o dorsum_out.%J
#BSUB -e dorsum_err.%J

/usr/local/usrapps/n2fix/jdeaver/dorado-0.6.2-linux-x64/bin/dorado demux --output-dir barcoded-bam --no-classify sup_calls-v2.bam
