interactive -p quanah

cd /lustre/scratch/jmanthey/06_dryobates/05_trees100kbp/windows

# combine all the trees and include a list of all the tree names (position in genome)
for i in $( ls *bipartitions* ); do echo $i >> ../dryobates_tree_list.txt; cat $i >> ../dryobates_100kbp.trees; done

# combine the output for different analyses into a single file each
# first add a header for each file
grep 'pop1' CM025994.1__10000001__10100000__stats.txt > ../window_heterozygosity.txt
grep 'pop1' CM025994.1__10000001__10100000__stats.txt > ../window_pi.txt
grep 'pop1' CM025994.1__10000001__10100000__stats.txt > ../window_fst.txt
grep 'pop1' CM025994.1__10000001__10100000__stats.txt > ../window_dxy.txt
grep 'pop1' CM025994.1__10000001__10100000__stats.txt > ../window_tajima.txt


# add the relevant stats to each file
for i in $( ls *__stats.txt ); do grep 'heterozygosity' $i >> ../window_heterozygosity.txt; done
for i in $( ls *__stats.txt ); do grep 'pi' $i >> ../window_pi.txt; done
for i in $( ls *__stats.txt ); do grep 'Tajima_D' $i >> ../window_tajima.txt; done
for i in $( ls *__stats.txt ); do grep 'Dxy' $i >> ../window_dxy.txt; done
for i in $( ls *__stats.txt ); do grep 'Fst' $i >> ../window_fst.txt; done
