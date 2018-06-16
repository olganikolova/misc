###############################################
# example of how to retrieve and upload data from and 
# to Synapse using query statements
###############################################

td <- tempdir()

query <- synapseQuery("select name, id from entity where parentId == '<synid1>'") 

lapply(1:nrow(query), function(idx){
  fname <- query$entity.name[idx]
  newfname <- gsub(".tsv",".rds",fname)
  synid <- query$entity.id[idx]
  f <- read.table(synGet(synid)@filePath, header=T, sep="\t", row.names=1)
   
  cat(dim(f))
  saveRDS(f, file=file.path(td, newfname))
  file <- File(file.path(td, newfname), parentId = "<synid2>") 
  file <- synStore(file)
  cat(fname, "pushed\n")
})
