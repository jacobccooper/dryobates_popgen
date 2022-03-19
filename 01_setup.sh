cd /lustre/scratch/jmanthey/06_dryobates
# make all directories 
mkdir 00_fastq
mkdir 01_cleaned
mkdir 01_bam_files
mkdir 02_vcf
mkdir 03_vcf
mkdir 10_align_script
mkdir 12_filter
mkdir 04_relernn
mkdir 05_trees100kbp
mkdir 05_trees100kbp/windows
mkdir 06_admixture
mkdir 07_admixture_windows
mkdir 07_admixture_windows/windows


# move all the raw fastq data to the 00_fastq directory with a file transfer program

# change directory to the raw data directory
cd /lustre/scratch/jmanthey/06_dryobates/00_fastq

# rename some of the files that don't have the right format of names
while read -r name1 name2; do
	mv $name1 $name2
done < rename_subset.txt

# some samples had more than one sequencing run
# concatenate the files
cat 11987_S1_L002_R1_001.fastq.gz >> Dryobates_pubescens_KU11987_R1.fastq.gz
cat 11987_S1_L002_R2_001.fastq.gz >> Dryobates_pubescens_KU11987_R2.fastq.gz
cat 15939_S2_L002_R1_001.fastq.gz >> Dryobates_pubescens_KU15939_R1.fastq.gz
cat 15939_S2_L002_R2_001.fastq.gz >> Dryobates_pubescens_KU15939_R2.fastq.gz
cat 29797_S4_L002_R1_001.fastq.gz >> Dryobates_scalaris_KU29797_R1.fastq.gz
cat 29797_S4_L002_R2_001.fastq.gz >> Dryobates_scalaris_KU29797_R2.fastq.gz
cat 29815_S5_L002_R1_001.fastq.gz >> Dryobates_nuttallii_KU29815_R1.fastq.gz
cat 29815_S5_L002_R2_001.fastq.gz >> Dryobates_nuttallii_KU29815_R2.fastq.gz
cat 29816_S6_L002_R1_001.fastq.gz >> Dryobates_nuttallii_KU29816_R1.fastq.gz
cat 29816_S6_L002_R2_001.fastq.gz >> Dryobates_nuttallii_KU29816_R2.fastq.gz
cat 30061_S3_L002_R1_001.fastq.gz >> Dryobates_scalaris_KU30061_R1.fastq.gz
cat 30061_S3_L002_R2_001.fastq.gz >> Dryobates_scalaris_KU30061_R2.fastq.gz
cat 31343_S10_L002_R1_001.fastq.gz >> Dryobates_nuttallii_KU31343_R1.fastq.gz
cat 31343_S10_L002_R2_001.fastq.gz >> Dryobates_nuttallii_KU31343_R2.fastq.gz
cat 32627_S11_L002_R1_001.fastq.gz >> Dryobates_pubescens_KU32627_R1.fastq.gz
cat 32627_S11_L002_R2_001.fastq.gz >> Dryobates_pubescens_KU32627_R2.fastq.gz

# remove the recently concatenated files
rm *L002*

