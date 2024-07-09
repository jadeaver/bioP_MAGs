#!/bin/bash

#BSUB -n 1
#BSUB -W 10
#BSUB -R span[hosts=1]
#BSUB -J merge-fq
#BSUB -o out.%J
#BSUB -e err.%J

cat *.fq.gz > merged.filt.fq.gz
