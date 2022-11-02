library(data.table)

dx=as.data.table(read.delim("45273.x.bed", stringsAsFactors = FALSE, header = FALSE))
df=as.data.table(read.delim("45273.fst.bed", stringsAsFactors = FALSE, header = FALSE))
dr=as.data.table(read.delim("45273.r.bed", stringsAsFactors = FALSE, header = FALSE))

dx$Z <-(dx$V4-mean(dx$V4))/sd(dx$V4)
df$Z <-(df$V4-mean(df$V4))/sd(df$V4)
dr$Z <-(dr$V4-mean(dr$V4))/sd(dr$V4)

dxtop<-setorder(setDT(dx), -Z)[, head(.SD, 453)]
drtop<-setorder(setDT(dr), Z)[, head(.SD, 453)]
dftop<-setorder(setDT(df), -Z)[, head(.SD, 453)]

write.table(dr,"Zratio_45273.txt",sep="\t",row.names=FALSE, col.names = FALSE,quote = FALSE)
write.table(drtop,"topratio_45273.txt",sep="\t",col.names = FALSE, row.names=FALSE, quote = FALSE)

write.table(dx,"Zxpehh_45273.txt",sep="\t",row.names=FALSE, col.names = FALSE,quote = FALSE)
write.table(dxtop,"topxpehh_45273.txt",sep="\t",col.names = FALSE, row.names=FALSE, quote = FALSE)

write.table(df,"Zfst_45273.txt",sep="\t",row.names=FALSE, col.names = FALSE,quote = FALSE)
write.table(dftop,"topfst_45273.txt",sep="\t",col.names = FALSE, row.names=FALSE, quote = FALSE)

