# remove all partial chromosome vcfs
rm *__*

# combine those chromosomes that were split
grep -v "#" CM026039.1b.g.vcf >> CM026039.1.g.vcf
