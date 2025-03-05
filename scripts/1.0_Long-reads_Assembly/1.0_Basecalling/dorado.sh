#!/bin/bash

#BSUB -n 32
#BSUB -W 00:30
#BSUB -J dorado
#BSUB -R "span[hosts=1]"
#BSUB -R "select[h100]"
#BSUB -q new_gpu
#BSUB -gpu "num=1:mode=shared:mps=no"
#BSUB -o dorado_out.%J
#BSUB -e dorado_err.%J

/usr/local/usrapps/n2fix/jdeaver/dorado-0.6.2-linux-x64/bin/dorado basecaller /usr/local/usrapps/n2fix/jdeaver/model/dna_r10.4.1_e8.2_400bps_sup@v4.3.0 /share/n2fix/jdeaver/metagenomes/long-read/pod5s --kit-name SQK-NBD114-24 > sup_calls.bam
