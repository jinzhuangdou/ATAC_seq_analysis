library(DiffBind)
library(Seurat)
library(DiffBind)

####### get peak profiles from MACS2 #### 

samples <- read.csv('sample.csv')
dbObj <- dba(sampleSheet=samples)
dbObj <- dba.count(dbObj, bUseSummarizeOverlaps=TRUE)
saveRDS(dbObj, file="dbObj.RDS")


####### calculate gene activity score using Seurat ##### 
# calculate gene activity score 
obj<-readRDS(file="./dbObj.RDS")
obj <- dbObj
dt <- obj$peaks 
meta <- dt[[1]]
peakName <- paste0(meta[,1],"-",meta[,2],"-",meta[,3])
peak <-c()
for(i in seq(1,nrow(samples),1)){
	peak<-cbind(peak, dt[[i]][,5])
}


rownames(peak) <- peakName
#sampleID <- readRDS(file="./sampleID.RDS")
#colnames(peak) <- sampleID[,1]
colnames(peak) <- dbObj$samples$SampleID
saveRDS(peak,file="peak.mat.RDS")



library(Seurat)
library(Matrix)
peak <- readRDS(file="peak.mat.RDS")


peak <- peak[!grepl("KI", rownames(peak)),]
peak <- peak[!grepl("GL", rownames(peak)),]
peak <- peak[!grepl("MT", rownames(peak)),]
library(reshape2)
tp <- colsplit(peak,"-",c("id1","id2","id3"))[,1]

library(Seurat)

#rownames(peak) <- paste0("chr", rownames(peak))
activity <-  CreateGeneActivityMatrix(peak.matrix = peak ,
     annotation.file = "/home/jdou1/software/refdata-cellranger-atac-GRCh38-1.2.0/genes/genes.gtf",
seq.levels =  paste("chr",c(1:22, "X","Y"), sep=""), upstream =2000, verbose = TRUE)
saveRDS(activity,file="./geneActivity.RDS")
