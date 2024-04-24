Note: need to prepare for the sampleLst1 for your fastq file  
      need to prepare for the sample.csv as required by diffbind tool  
Step1: run read alginment
   -> input sampleLst1, sampleLst2 
   -> bash read_alignment.sh 

Step2: generate peak and gene activity matrix from Seurat 
  -> input sample.csv 
  -> Rscript runDiffBind.R 
