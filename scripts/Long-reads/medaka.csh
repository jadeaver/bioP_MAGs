#!/bin/tcsh

#BSUB -n 8
#BSUB -W 18:00
#BSUB -J medaka
#BSUB -R "span[hosts=1]"
#BSUB -o medaka_out.%J
#BSUB -e medaka_err.%J

module load conda

conda activate /usr/local/usrapps/n2fix/jdeaver/medaka-1.11.3

set basecalls = /share/n2fix/jdeaver/metagenomes/long-read/4.0_filtered-fq/merged.filt.fq.gz
set draft_assembly = /share/n2fix/jdeaver/metagenomes/long-read/5.0_assemblies/co-assembly/assembly.fasta
set output_dir = /share/n2fix/jdeaver/metagenomes/long-read/6.0_medaka
set model = r1041_e82_400bps_sup_v4.3.0

medaka_consensus -i ${basecalls} -d ${draft_assembly} -o ${output_dir} -t 4 -m ${model}

conda deactivate
