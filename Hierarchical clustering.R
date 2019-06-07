# Hierarchical clustering
rm(list=ls())
set.seed(5)
# preparation of data and features
mydata=read.csv('Liion_comp_528.csv')
# Get the mxrd representation from the data frame
X_ini=as.matrix(mydata[,5:4505])
# known li-ion conductivity values 
y=mydata$log10_cond




# Examine number of clusters from hierarchical clustering, by examine the variance
# function returning the variance
myobj=function(X){
  ncut_vec=seq(2,10)
  hc_df=mydata[,c('formula_id','index','log10_cond')]
  hc_df[,as.character(ncut_vec)]=NA
  hc_run <- hclust(dist(X),method="ward.D2")
  for (cut_dex in 1:length(ncut_vec)){
    ncuts=ncut_vec[cut_dex]
    mycut=cutree(hc_run,ncuts)
    hc_df[,as.character(ncuts)]=mycut
  }
  hc_sum=data.frame(matrix(NA,nrow=length(ncut_vec),ncol=1))
  colnames(hc_sum)=c('label_var')
  rownames(hc_sum)=as.character(ncut_vec)
  # use the measure of summing both labeled and unlabeled
  for (group_meth in as.character(ncut_vec)){
    aggcount=aggregate(hc_df[,'log10_cond'],list(hc_df[,group_meth]),function(x)sum(!is.na(x)))
    out_stat=matrix(NA,nrow=nrow(aggcount),ncol=3)
    colnames(out_stat)=c('gp','count','var')
    aggvar=aggregate(na.omit(hc_df)[,'log10_cond'],list(na.omit(hc_df)[,group_meth]),var)
    out_stat[,'gp']=aggcount[,1]
    out_stat[,'count']=aggcount[,2]
    out_stat[match(aggvar[,1],out_stat[,'gp']),'var']=aggvar[,2]
    myout3=sum(out_stat[,'count']*out_stat[,'var'],na.rm=T)
    hc_sum[group_meth,'label_var']=myout3
  }
  return((hc_sum))
}

# print the variance for different number of cuts
myobj(X_ini)


# cut into 7 clusters, since it gives the largest drop in variance
hc_out=hclust(dist(X_ini),method='ward.D2')
mycut=cutree(hc_out,7)