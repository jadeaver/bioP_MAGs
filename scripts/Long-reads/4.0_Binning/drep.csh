#!/bin/tcsh

#BSUB -n 16
#BSUB -W 4:00
#BSUB -J dRep
#BSUB -R "span[hosts=1]"
#BSUB -q ccee
#BSUB -o drep_out.%J
#BSUB -e drep_err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/drep-3.5.0

set bins_dir = "/share/n2fix/jdeaver/metagenomes/long-read/7.0_binning"
set drep_dir = "/share/n2fix/jdeaver/metagenomes/long-read/8.0_dRep"

set ANI98_dir = "/share/n2fix/jdeaver/metagenomes/long-read/8.0_dRep/ANI_98"
set ANI95_dir = "/share/n2fix/jdeaver/metagenomes/long-read/8.0_dRep/ANI_95"

set asmbl_dirs = (B1_D4 B2_D1 B2_D2 B2_D3 B2_D4 B3_D1 B3_D2 B3_D3 co-assembly D1 D2 D3 D4)

foreach asmbl_dir ($asmbl_dirs)
	set bin_folder = "${bins_dir}/${asmbl_dir}/${asmbl_dir}_DASTool_bins"
	set bins4drep = "${drep_dir}/bins"

	cp $bin_folder/*.fa $bins4drep
end

dRep dereplicate $ANI98_dir -p 16 -g $drep_dir/bins/*.fa -sa 0.98
dRep dereplicate $ANI95_dir -p 16 -g $drep_dir/bins/*.fa -sa 0.95

conda deactivate
