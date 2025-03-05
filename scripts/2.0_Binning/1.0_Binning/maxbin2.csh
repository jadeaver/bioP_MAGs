#!/bin/tcsh

#BSUB -n 16
#BSUB -W 3:00
#BSUB -J maxbin2
#BSUB -q ccee
#BSUB -R "span[hosts=1]"
#BSUB -o maxb2_out.%J
#BSUB -e maxb2_err.%J

# The purpose of this script is to bin reads mapped to each of the 13 assemblies accounting for differential coverage of all 8 samples to each assembly 
# (i.e. all samples are mapped to each assembly and binned together for that assembly).

conda activate /usr/local/usrapps/n2fix/jdeaver/maxbin2-2.2.7

set asmbl_parent_dir = "/share/n2fix/jdeaver/metagenomes/long-read/6.1_polished/ratatosk"
set binning_dir = "/share/n2fix/jdeaver/metagenomes/long-read/7.0_binning"

set asmbl_dirs = (B1_D4 B2_D1 B2_D2 B2_D3 B2_D4 B3_D1 B3_D2 B3_D3 co-assembly D1 D2 D3 D4)
set asmbl_name = "assembly.fasta"

foreach asmbl_dir ($asmbl_dirs)
	set dir = "${binning_dir}/${asmbl_dir}"
	set asmbl_file = "${asmbl_parent_dir}/${asmbl_dir}/${asmbl_name}"

	cut -f1,4,6,8,10,12,14,16,18 ${dir}/depth.txt > ${dir}/maxbin.txt

	run_MaxBin.pl -thread 16 -min_contig_length 2500 -contig $asmbl_file -abund $dir/maxbin.txt -out $dir/bins/bin_maxbin2_${asmbl_dir}
end

conda deactivate
