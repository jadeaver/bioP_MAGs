#!/bin/tcsh

#BSUB -n 16
#BSUB -W 6:00
#BSUB -J dRep
#BSUB -R "span[hosts=1]"
#BSUB -o drep_out.%J
#BSUB -e drep_err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/drep-3.5.0

set bins_dir = "/share/n2fix/jdeaver/metagenomes/long-read/7.0_binning"
set dRep_dir = "/share/n2fix/jdeaver/metagenomes/long-read/8.0_dRep"

set asmbl_dirs = (B1_D4 B2_D1 B2_D2 B2_D3 B2_D4 B3_D1 B3_D2 B3_D3 co-assembly)

foreach asmbl_dir ($asmbl_dirs)
	set bin_folder = "${bins_dir}/${asmbl_dir}/bins"
	set bins4drep = "${dRep_dir}/bins"

	cp $bin_folder/*.fa $bins4drep
end

dRep dereplicate $dRep_dir -p 16 -g $dRep_dir/bins/*.fa

conda deactivate
