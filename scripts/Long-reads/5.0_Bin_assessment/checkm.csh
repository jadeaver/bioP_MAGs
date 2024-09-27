#!/bin/tcsh

#BSUB -n 16
#BSUB -W 4:00
#BSUB -J checkM
#BSUB -R "span[hosts=1]"
#BSUB -o checkM_out.%J
#BSUB -e checkM_err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/checkm-1.1.6

set parent_dir = "/share/n2fix/jdeaver/metagenomes/long-read/7.0_binning"

set asmbl_dirs = (B1_D4 B2_D1 B2_D2 B2_D3 B2_D4 B3_D1 B3_D2 B3_D3 co-assembly D1 D2 D3 D4)

foreach asmbl_dir ($asmbl_dirs)
		set bins_folder = "${parent_dir}/${asmbl_dir}/bins"
		set outputFolder = "${parent_dir}/${asmbl_dir}/${asmbl_dir}_checkm"
		set table = "${asmbl_dir}_table.tsv"

		checkm lineage_wf -t 16 -x fa -f $table $bins_folder $outputFolder
end

conda deactivate
