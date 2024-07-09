#!/bin/tcsh

#BSUB -n 8
#BSUB -W 30
#BSUB -R span[hosts=1]
#BSUB -J Quast
#BSUB -o out.%J
#BSUB -e err.%J

module load conda

conda activate /usr/local/usrapps/n2fix/jdeaver/quast-5.2.0

set base_dir = "/share/n2fix/jdeaver/metagenomes/long-read/5.0_assemblies"
set out_dir = "/share/n2fix/jdeaver/metagenomes/long-read/5.1_QUAST"

/usr/local/usrapps/n2fix/jdeaver/quast-5.2.0/bin/quast.py -o $out_dir/dual-assembly $base_dir/dual-assembly/assembly.fasta --threads 8
/usr/local/usrapps/n2fix/jdeaver/quast-5.2.0/bin/quast.py -o $out_dir/single_2G-11-20-23 $base_dir/single_2G-11-20-23/assembly.fasta --threads 8

conda deactivate

