library(gdsfmt)
library(SNPRelate)
library(dplyr)


vcf.fn = "<your vcf here>"

snpgdsVCF2GDS(vcf.fn, "all_chicken.gds", method="biallelic.only")
genofile <- snpgdsOpen("all_chicken.gds")

pca <- snpgdsPCA(genofile, autosome.only = F, maf=0.02, missing.rate=0.2)

pc.percent <- pca$varprop*100
pc = head(round(pc.percent, 2))

breedmap = read.table("107.breedmap.txt",fill=TRUE)
sample.id = as.character(breedmap$V1)
breed_code = as.character(breedmap$V2)

col.list <- c("deepskyblue1","slateblue1", "grey34", "Orange", "lightblue", "springgreen4","pink","red", "yellow3", "violetred4")
shape.list <-c(0,1,2,3,4,5,6,7,8,9)


par(mar = c(5,5,5,5))

plot(tab$EV2, tab$EV1, col=col.list[as.integer(tab$breed_code)], pch=shape.list[as.integer(tab$breed_code)],cex = 3, lwd=2, xlab="", ylab="")

mtext(side=1, line=3, paste("PC2 (", pc[2],"%)"), font=2,cex=1.7)
mtext(side=2, line=3, paste("PC1 (", pc[1],"%)"), font=2, cex=1.7)

axis(1,font=2)
axis(2,font=2)

legend("topright", legend=levels(tab$breed_code), cex = 1.4,pch=shape.list[1:nlevels(tab$breed_code)], col=col.list[1:nlevels(tab$breed_code)])
#legend("bottomleft", legend=levels(tab$breed_code), cex = 1,pch=shape.list[1:nlevels(tab$breed_code)], col=col.list[1:nlevels(tab$breed_code)])


dev.off()

