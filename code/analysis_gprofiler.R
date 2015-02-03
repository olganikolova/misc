## functional annotation analysis
## of screen hits for both 
## negative (killer) and positive (resistant) tails
options(stringsAsFactors=FALSE)
setwd("/fh/.../brca/")
library(gProfileR)

DATAHOME <- "results/hits"
OUTPUTHOME <- "gprofiler"

allff <- list.files(DATAHOME)
allf <- allff[grep('IC0.HITS.tsv', allff)]

# negative tail
for(i in 1:length(allf)){
  
  NAM <- allf[i]
  NEWNAM <- paste(gsub(".tsv","", NAM), "_NEG", sep="")
  
  D <- read.delim(file.path(DATAHOME, NAM), sep="\t", header=T)
  
  # here I order my background by one of three variables
  # since the file name contains the key variable I grep 
  # on the file name
  DORD <- D[with(D, order(if(length(grep("DIF",NAM)) > 0){
    -Differential_mean
  }else if (length(grep("FC",NAM)) > 0){
    -Fold_change_mean
  } else {
    Z_Score
  })),]
  
  # ordered background
  BG <- unique(DORD$Gene_symbol)
  
  QDFN <- subset(DORD, Hits < 0 )
  QDFORDN <- QDFN[with(QDFN, order(if(length(grep("DIF",NAM)) > 0){
    -Differential_mean
  }else if (length(grep("FC",NAM)) > 0){
    -Fold_change_mean
  } else {
    Z_Score
  })),]
  
  # ordered query
  Q <- unique(QDFORDN$Gene_symbol)
  
  FTXT <- file.path(OUTPUTHOME, paste(NEWNAM,"_UNORD.tsv", sep=""))
  FPNG <- file.path(OUTPUTHOME, paste(NEWNAM,"_UNORD.png", sep=""))
  # gprofiler unordered txt
  gprofiler(Q, custom_bg=BG, 
            correction_method="fdr",
            #max_p_value=0.1,
            png_fn=FPNG)
  
  GUN <- gprofiler(Q, custom_bg=BG, 
                   correction_method="fdr",
                   #max_p_value=0.1,
                   png_fn=NULL)
  write.table(GUN,FTXT, sep="\t", col.names=T, row.names=F, quote=F)
  cat("*** writing ", FTXT, "...\n")
  
  FTXT <- file.path(OUTPUTHOME, paste(NEWNAM,"_ORD.tsv", sep=""))
  FPNG <- file.path(OUTPUTHOME, paste(NEWNAM,"_ORD.png", sep=""))
  
  # gprofiler ordered txt
  gprofiler(Q, custom_bg=BG, 
            ordered_query=T,
            correction_method="fdr",
            #max_p_value=0.1,
            png_fn=FPNG)
  
  GOR <- gprofiler(Q, custom_bg=BG, 
                   ordered_query=T,
                   correction_method="fdr",
                   #max_p_value=0.1,
                   png_fn=NULL)
  
  write.table(GOR,FTXT, sep="\t", col.names=T, row.names=F, quote=F)
  cat("*** writing ", FTXT, "...\n")
}
