#!/bin/tcsh

#BSUB -n 32
#BSUB -W 3:00
#BSUB -J GTDB-Tk
#BSUB -R "span[hosts=1]"
#BSUB -R select[stc]
#BSUB -q ccee
#BSUB -o gtdb_out.%J
#BSUB -e gtdb_err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/gtdbtk-2.4.0

set drep98_bins = "/share/n2fix/jdeaver/metagenomes/long-read/8.0_dRep/ANI_98/dereplicated_genomes"
set out98_dir = "/share/n2fix/jdeaver/metagenomes/long-read/9.0_MAG-analysis/GTDB-Tk/ANI_98"

set drep95_bins = "/share/n2fix/jdeaver/metagenomes/long-read/8.0_dRep/ANI_95/dereplicated_genomes"
set out95_dir = "/share/n2fix/jdeaver/metagenomes/long-read/9.0_MAG-analysis/GTDB-Tk/ANI_95"

set temp = "/share/n2fix/jdeaver/metagenomes/long-read/9.0_MAG-analysis/GTDB-Tk/tmp"

gtdbtk classify_wf --genome_dir $drep98_bins --extension fa --out_dir $out98_dir --mash_db $out98_dir/mash --cpus 32 --tmpdir $temp
gtdbtk classify_wf --genome_dir $drep95_bins --extension fa --out_dir $out95_dir --mash_db $out95_dir/mash --cpus 32 --tmpdir $temp

conda deactivate
