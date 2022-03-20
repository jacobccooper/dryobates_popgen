grep "#" CM026036.1_nuttallii.recode.vcf > nuttallii_relernn.vcf

grep "#" CM026036.1_scalaris.recode.vcf > scalaris_relernn.vcf

grep "#" CM026036.1_pubescens.recode.vcf > pubescens_relernn.vcf

for i in $( ls *nuttallii.recode* ); do grep -v "#" $i >> nuttallii_relernn.vcf; done

for i in $( ls *scalaris.recode* ); do grep -v "#" $i >> scalaris_relernn.vcf; done

for i in $( ls *pubescens.recode* ); do grep -v "#" $i >> pubescens_relernn.vcf; done
