#!/bin/tcsh

#BSUB -n 8
#BSUB -W 30
#BSUB -R span[hosts=1]
#BSUB -J Quast
#BSUB -o out.%J
#BSUB -e err.%J

# An example script for how QUAST was used to check assembly statistics

conda activate /usr/local/usrapps/n2fix/jdeaver/quast-5.2.0

set base_dir = "/share/n2fix/jdeaver/metagenomes/long-read/5.0_assemblies/ratatosk/co-assembly"
set out_dir = "/share/n2fix/jdeaver/metagenomes/long-read/5.1_QUAST/ratatosk"

/usr/local/usrapps/n2fix/jdeaver/quast-5.2.0/bin/quast.py -o $out_dir/co-assembly $base_dir/assembly.fasta --threads 8


conda deactivate

