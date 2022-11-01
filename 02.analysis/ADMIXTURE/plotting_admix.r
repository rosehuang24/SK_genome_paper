setwd("~/Desktop/Stats/ADMIX")
library(dplyr)
#tests for different color combinations. I kinda enjoy it.

cbPalette <- c( "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7","#999999")
kp2<-c("#E69F00", "#56B4E9")
kp3<-c("#E69F00", "#56B4E9", "#009E73")

kp4_1<-c("#009E73", "#E69F00", "#F0E442", "#56B4E9")
kp4<-c("#009E73", "#E69F00", "#56B4E9", "#F0E442")

kp5_1<-c("#F0E442","#0072B2", "#009E73", "#E69F00", "#56B4E9")
kp5<-c("#56B4E9","#F0E442", "#009E73", "#E69F00", "#0072B2")

kp6_1<-c("#D55E00","#0072B2", "#009E73", "#56B4E9", "#E69F00","#F0E442")
kp6<-c("#D55E00","#F0E442","#009E73", "#0072B2", "#E69F00", "#56B4E9")

kp7_1<-c("#009E73", "#F0E442", "#D55E00", "#0072B2", "#CC79A7", "#56B4E9", "#E69F00")
kp7<-c("#009E73", "#56B4E9", "#CC79A7", "#F0E442", "#D55E00", "#0072B2", "#E69F00")


kp8_1<-c("#009E73","#CC79A7", "#999999", "#D55E00", "#F0E442", "#0072B2", "#56B4E9", "#E69F00")
kp8<-c("#009E73", "#D55E00", "#999999","#CC79A7", "#56B4E9", "#F0E442", "#0072B2", "#E69F00")

#level_order <-c("WLH","SK","WHYC","LX","TLF","YNLC","YVC","TBC","DULO","RJF")

#tbl<- read.table("results/input.3.py0.9.for_admix.4.result.table", header = FALSE)

#tbl<-tbl %>%arrange(factor(V2, levels = level_order), -V1)

#tbl%>%filter(V2="RJF")

#tm<-tbl%>%select(-V1, -V2)

#m<-as.matrix(tm)
#rownames(m)<-tbl$V2

#barplot(t(m),col= kp8,xlab="Individual", ylab="Ancestry",border = NA,space = 0.1)

library(ggplot2)
library(tidyverse)
library(tidytext)
library(dplyr)
library(reshape2)

level_order <-c("WLH","SK","WHYC","LX","TLF","YNLC","YVC","TBC","DULO","RJF")
#level_order <-c("WLH","SK","WHYC","LX","TLF","YNLC","YVC","TBC","DULO","L7","L8","L9","L0","W1","W2","W3","W4","W5")

#tbl<- read.table("results/input.3.py0.9.for_admix.4.result.table", header = FALSE)
#tbl<- read.table("result_RJFparted/input.3.py0.9.for_admix.7.result.table", header = FALSE)
tbl <-read.table("input4/input.4.for_admix.pruned.8.result.table", header = FALSE)

tbl <- melt(tbl, id=c("V1","V2"))
tbl<- tbl%>%rename(indv=V1, breed=V2,anc = variable)
#%>%arrange(as.character(breed,levels=level_order), indv)

##K8 for example
pdf(file = "K8.input.4.squished.pdf", width = 20,height =1.81) 

p <- ggplot(tbl, aes(indv,value)) +
  geom_col(aes(fill=anc), width = 1,
           position="fill")+
  scale_fill_manual(values = kp8)+
 # guides(fill = guide_legend(title = ""))+
  labs(x=" ", y="K = 8")+
  coord_cartesian(expand = FALSE)+
  theme_bw()+
  theme(axis.title.x=element_blank(), 
        axis.text=element_blank(), 
        axis.ticks=element_blank(),
        strip.background = element_blank(),
        #strip.text.x = element_blank(),
        axis.title.y = element_text(size=16, face="bold", 
                                    margin = margin(t = 10, r = 10, b = 10, l = 10)),
        legend.position = "none")



p+facet_grid(~ factor(breed, levels = level_order), 
             scales="free", space="free", switch="x")+
  theme(strip.text.x = element_text(size = 16, face="bold"),
        panel.spacing.x = unit(0,"cm"))+scale_y_reverse()#for K=6 and 8


dev.off()

#############################
##_____make plot for CV____##
################################

#CV for each K can be grepped from job report

df <- read.delim("input4/CV", header = FALSE,col.names = c("K", "CV"))

p<- ggplot(df, aes(K,CV))+
  theme_light()+
  theme(plot.title=element_text(size=20,face="bold", margin = margin(t = 20, b = 20)),
        axis.text.y=element_text(size=12,face="bold"), 
        axis.text.x = element_text(size=12,face="bold"),
        #axis.title = element_text(size=16,margin = margin(t = 0, r = 10, b = 10, l = 10)),
        axis.title.y = element_text(size=16,face="bold", margin = margin(t = 10, r = 10, b = 10, l = 10)),
        axis.title.x = element_text(size=16, face="bold",margin = margin(t = 10, r = 10, b = 10, l = 10)))



p+geom_line(color="indianred4", size=1.5, alpha=.8)+
  geom_point(color="indianred4", size=2)+
  scale_x_continuous("K", breaks = 2:8)+
  ylim(c(0.31, 0.355))
  
