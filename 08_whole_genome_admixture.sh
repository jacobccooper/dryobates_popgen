# start interactive session
interactive -p quanah

# move to directory
cd /lustre/scratch/jmanthey/06_dryobates/06_admixture

# make one vcf
grep "#" CM025994.1.recode.vcf > total.vcf
for i in $( ls *recode.vcf ); do grep -v "#" $i >> total.vcf; done

# remove all partial files
rm *recode.vcf

# make chromosome map for the vcf
grep -v "#" total.vcf | cut -f 1 | uniq | awk '{print $0"\t"$0}' > chrom_map.txt

# run vcftools for the combined vcf
vcftools --vcf total.vcf  --plink --chrom-map chrom_map.txt --out total 

# convert  with plink
plink --file total --recode12 --out total2 --noweb

# run admixture 
admixture --cv total2.ped 3 | tee log_3.out


