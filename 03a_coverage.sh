#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=dryo_depth
#SBATCH --partition quanah
#SBATCH --nodes=1 --ntasks=3
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G

samtools depth -a Dendropicos_abyssinicus_EB034_final.bam Dryobates_nuttallii_KU29815_final.bam \
Dryobates_nuttallii_KU29816_final.bam Dryobates_nuttallii_KU31337_final.bam \
Dryobates_nuttallii_KU31343_final.bam Dryobates_nuttallii_KU39796_final.bam \
Dryobates_pubescens_KU11987_final.bam Dryobates_pubescens_KU15939_final.bam \
Dryobates_pubescens_KU32627_final.bam Dryobates_pubescens_KU35810_final.bam \
Dryobates_pubescens_KU7447_final.bam Dryobates_scalaris_KU29797_final.bam \
Dryobates_scalaris_KU30061_final.bam Dryobates_scalaris_KU30064_final.bam \
Dryobates_scalaris_KU30076_final.bam Dryobates_scalaris_KU30077_final.bam > \
dryobates_coverage.txt


# break up the depth files into single column files for each individual (locations dropped)

while read -r name1 number1; do
	number2=$((number1 + 2));
  cut dryobates_coverage.txt -f $number2 > ${name1}_depth.txt;
done < dryo_popmap.txt
