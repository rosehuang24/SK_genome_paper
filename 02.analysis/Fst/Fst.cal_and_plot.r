library(gdsfmt)
library(SNPRelate)
library(dplyr)

vcf.fn = "<your VCF here>"
snpgdsVCF2GDS(vcf.fn, "all_chicken.gds", method="biallelic.only")


genofile <- snpgdsOpen("all_chicken.gds")

#set names for matrix vectors
breedmap= read.table("107indvs.txt",fill=TRUE) 

#space-delim files. All individuals in one line. I just ¨¨¨ paste -sd ' ' < (cut -f {column number} breedmap.file) ¨¨¨
sample.id <- scan("sample.id.txt", what=character())
pop_code <- scan("pop_code.txt", what=character())


#create matrix
mymat <- matrix(nrow=10, ncol=10)
colnames(mymat)<-c(levels(breedmap$V2))
rownames(mymat)<-c(levels(breedmap$V2))

#fFst calculation for each cell
for(i in 1:10) {
  for(j in 1:10) {
    if(i!=j){
      mymat[i,j] = snpgdsFst(genofile, 
                             sample.id=sample.id[pop_code %in% c( pop_1=colnames(mymat)[i], pop_2=rownames(mymat)[j])], 
                             population=as.factor(pop_code[pop_code %in% c( pop_1=colnames(mymat)[i], pop_2=rownames(mymat)[j])]),
                             method="W&C84")$Fst
    }
  }
}


###############################
##___ploting corr plot_______#
###############################


library(corrplot)

col.order <- c("WLH",
               "SK",
               "LX",
               "DULO",
               "WHYC",
               "TBC",
               "TLF",
               "YNLC",
               "YVC",
               "RJF")

SM<-mymat[col.order,col.order]

SM[upper.tri(SM)] <- NA

#SM[is.na(SM)] <-col.order

corrplot(SM,is.corr = FALSE,
         method = 'color',
         col= colorRampPalette(c("dodgerblue4","white", "firebrick"))(200),
         diag = FALSE,
         tl.col = 'black',
         tl.srt = 0,
         tl.cex=1.3,
         col.lim=c(0, 0.32),
         tl.pos = 'd', cl.pos = 'b', na.label = ' ')

text(x=col(SM),y=11-row(SM),round(SM,3))

