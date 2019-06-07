### hierarchical-clustering
### Read me file for Hierarchical clustering 
Hierarchical clustering of mxrd spectrum for Li-ion 

### System requirements:
Operating system: windows 7, 64bit
Software: R version 3.3.3 

### Installation guide
Follow the standard procedure of installing R, as listed in CRAN website


### Instructions for use and expected output
For (agglomerative) hierarchical clustering, the function of "hclust" from R is utilzied to cluster the different Li-ion compounds based on the mxrd spectrum. Compared with K-means clustering, hierarchical clustering is advantageous because it doesn’t need to specify the number of clusters or different starting center positions. Ward Linkage is selected to measure the cluster dissimilarity because of its robustness against noise compared with other linkage methods (such as single, complete, centroid). The number of groups is obtained by examining the within-cluster variation. In this case, the largest drop in variation was 7. 


#### Input: Liion_comp_528.csv
	1st column is the formula_id
	2nd column is the index
	3rd column is the Li-ion conductivity (Missing values are NA)
	4th Column log10 transformed Li-ion conductivity
	5-4505th column: the mxrd at different angles

#### expected output
	Number of clusters with the corresponding within-cluster variation for the Li-ion conductivity

### expected runtime
<1 min on 8GM RAM, Intel i5-6300U CPU@2.4GHz
