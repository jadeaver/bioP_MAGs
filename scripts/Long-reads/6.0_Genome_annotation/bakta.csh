#!/bin/tcsh

#BSUB -n 8
#BSUB -W 1:30
#BSUB -J bakta
#BSUB -R "span[hosts=1]"
#BSUB -q ccee
#BSUB -o bakta_out.%J
#BSUB -e bakta_err.%J

# The purpose of this script is to annotate my PAO MAGs using bakta

conda activate /usr/local/usrapps/n2fix/jdeaver/bakta-1.9.4

set bins = "/share/n2fix/jdeaver/metagenomes/long-read/9.0_MAG-analysis/PAO_bins"
set dir = "/share/n2fix/jdeaver/metagenomes/long-read/9.0_MAG-analysis/bakta"
set db = "/share/n2fix/jdeaver/db"
set TMP_DIR = "/share/n2fix/jdeaver/tmp"

foreach file (`ls $bins/*.fa`)
	set base_name = `basename $file -contigs.fa`
	set out_dir = "$dir/${base_name}"

	bakta --db $db --verbose --output $out_dir --tmp-dir $TMP_DIR --threads 8 $file

end

conda deactivate
