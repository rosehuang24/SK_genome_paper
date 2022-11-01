#to modify the plink roh output, you'll need to cat FID and IID together with "_"
#and add a colomn of breed information

library(dplyr)
library(ggplot2)
library(ggsignif)


droh <- read.delim("input.4.roh",header = TRUE)

droh$category <- cut(droh$KB, 
                     breaks=c(-Inf, 300, 1000, Inf), 
                     labels=c("short(100kb~300kb)","long(300kb~1Mb)","mega(>1Mb)"))


level_order <- c("WHYC",'YNLC','RJF','TLF','DULO','YVC','TBC','LX','SK','WLH')
category_order <-c('short(100kb~300kb)','long(300kb~1Mb)','mega(>1Mb)')

#####-----------------------------------------------#####
#for calculating mean and standard deviation for each population 

#summary on number of segments for each individual
t<-droh%>%count(FID_IID)
t

#summary of length of each individual
t<-droh%>%filter(FID_IID =="Clean_01")%>%summarise(across(.cols = KB,list(mean = mean, sd = sd)))
t

#summary of length of each breed 
t<- droh%>%
  group_by(breed)%>%
  summarise(across(.cols = KB,list(mean = mean, sd = sd)))


#summary of number of segments of each breed 
t<-droh%>%count(breed,FID_IID)%>% group_by(breed) %>% summarise(across(.cols = n,list(mean = mean, sd = sd)))
t


#summary of number of segments of each breed on each category
t<-droh %>% 
  group_by(breed,category)%>% 
  count(breed,FID_IID,category)%>% 
  summarise(across(.cols = n,list(mean = mean, sd = sd)))
t

