# Reads the data as a table.
x<-read.table('mash.distances.final.txt', as.is=TRUE)

# Gets unique names
x.names<-sort(unique(c(x[[1]], x[[2]])))

# Creates matrix of right size including names.
x.dist<-matrix(0, length(x.names), length(x.names))
dimnames(x.dist)<-list(x.names, x.names)

# Creates indices by converting names and numbers then creating the normal and reversed numbers to fill the matrix.
x.ind<-rbind(cbind(match(x[[1]], x.names), match(x[[2]], x.names)), cbind(match(x[[2]], x.names), match(x[[1]], x.names)))
x.dist[x.ind] <- rep(x[[3]], 2)

print('Displaying table.');
x.dist
Sys.sleep(2)

# Loads libraries.
library(vegan)
library(ggplot2)

# Reads the map file.
metadata<-read.table('mapFile.txt', head=TRUE, sep='\t', check.name=F, row.names=1)

# Performs nonmetric multidimensional scaling analysis.
dist_mat<-dist(x.dist, method='euclidean')
Sys.sleep(2)
NMDS<-metaMDS(dist_mat, distance='bray')
MDS1<-NMDS$points[,1]
MDS2<-NMDS$points[,2]
NMDS = data.frame(MDS1=MDS1, MDS2=MDS2, Condition=metadata$Condition)

print('Displaying data frame.')
head(NMDS)
Sys.sleep(2)

print('Generating plot.')
ggplot(NMDS, aes(x=MDS1, y=MDS2, col=metadata$Condition))+geom_point(size=3)+theme_bw()+labs(title='NMDS Plot, stress=0.001')

print('Saving plot to file NMDS_mash_K25.pdf')
pdf(file='NMDS_mash_K25.pdf')
ggplot(NMDS, aes(x=MDS1, y=MDS2, col=metadata$Condition))+geom_point(size=3)+theme_bw()+labs(title='NMDS Plot, stress=0.001')
dev.off()
