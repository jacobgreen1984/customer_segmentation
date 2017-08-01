# title: map newdata 


# set load folder 
agile.loadFolder = "~/ȭ����/output/"

# �ű԰���
testId <- testDt[,.(CustomerID)]
testDt <- testDt[,mget(clusterVarLeft)]

# node, cluster���� 
somNodeClusterDt <- data.table(node=somModel$unit.classif,cluster=clusterNode[somModel$unit.classif])
somNodeClusterDt <- unique(somNodeClusterDt)


# scale����
scaleInfo <- readRDS(paste0(agile.loadFolder,"scaleInfo.Rda"))
if(paste(names(scaleInfo),collapse="")=="maxmin"){
  cat("use the following scale information: ","\n")
  print(data.frame(scaleInfo))
  testMtx  <- as.matrix(scale(testDt,center=scaleInfo$min,scale=scaleInfo$max-scaleInfo$min))
} else if(paste(names(scaleInfo),collapse="")=="centerscale"){
  cat("use the following scale information: ","\n")
  print(data.frame(scaleInfo))
  testMtx  <- as.matrix(scale(testDt,center=scaleInfo$center,scale=scaleInfo$scale))
} else cat("incorrect scale information!")


# ��� �Ҵ� 
outputMap <- kohonen::map(somModel,testMtx)                            
outputDt  <- data.table(testId,node=outputMap$unit.classif)


# ���� �Ҵ� 
setkey(somNodeClusterDt,node)                                                
setkey(outputDt,node)
outputDt <- outputDt[somNodeClusterDt]


#cat("done!")

















