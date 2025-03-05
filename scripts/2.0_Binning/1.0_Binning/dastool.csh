#!/bin/tcsh

#BSUB -n 16
#BSUB -W 2:00
#BSUB -J DasTool
#BSUB -R "span[hosts=1]"
#BSUB -o DasTool_out.%J
#BSUB -e DasTool_err.%J

conda activate /usr/local/usrapps/n2fix/jdeaver/dastool-1.1.7

set asmbl_parent_dir = "/share/n2fix/jdeaver/metagenomes/long-read/6.1_polished/ratatosk"
set binning_dir = "/share/n2fix/jdeaver/metagenomes/long-read/7.0_binning"

set asmbl_dirs = set asmbl_dirs = (B1_D4 B2_D1 B2_D2 B2_D3 B2_D4 B3_D1 B3_D2 B3_D3 co-assembly D1 D2 D3 D4)
set asmbl_name = "assembly.fasta"

foreach asmbl_dir ($asmbl_dirs)
	set dir = "${binning_dir}/${asmbl_dir}"
	set asmbl_file = "${asmbl_parent_dir}/${asmbl_dir}/${asmbl_name}"
	set input_file1 = "${dir}/maxbin2_contigs2bin.tsv"
	set input_file2 = "${dir}/metabat2_contigs2bin.tsv"

	DAS_Tool -i $input_file1,$input_file2 -c $asmbl_file -o ${dir}/${asmbl_dir} -t 16 --write_bins
end

conda deactivate
