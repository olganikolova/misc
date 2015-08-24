# source("https://bioconductor.org/biocLite.R")
# biocLite("IlluminaHumanMethylation450k.db")

require("IlluminaHumanMethylation450k.db")
# Convert the object to a list
xx <- as.list(IlluminaHumanMethylation450kALIAS2PROBE)
if(length(xx) > 0){
  # Get the probe identifiers for the first two aliases
  xx[1:2]
  # Get the first one
  xx[[1]]
}

