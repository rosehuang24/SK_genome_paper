
library(ggplot2)
library(dplyr)
library(reshape2)

level_order <-c("SK","WHYC","LX","TLF","YNLC","YVC","TBC","DULO","WLH","RJF")

d<-read.csv("input.4.SOBP_PDSS.chr3_67820000_67860000.phased.pos_geno.csv")
d<-melt(d,id=c("indv","breed"))

p<-ggplot(d,aes(indv, variable, fill= as.character(value)))



p+geom_tile()+
  facet_grid(rows = vars(factor(breed, levels = level_order)),
             space="free", 
             scale="free",
             switch="y")+
  coord_flip()+
  labs(x=" ")+
  theme(strip.text.y.left= element_text(size = 15, face="bold", angle=360),
        panel.spacing.y = unit(0,"cm"),
        panel.border = element_rect(fill = NA, color = "black", size=1),
        axis.title.x=element_blank(), 
        axis.text=element_blank(), 
        axis.ticks=element_blank(),
        strip.background = element_blank(),
        strip.text.x = element_blank(),
        legend.direction = "horizontal",
        legend.position = "bottom",
        legend.text=element_text(size=14))+
  scale_fill_manual(name=" ",
                    breaks=c("0","1","2","3"),
                    values = c("grey","coral2","darkred","ivory2"),
                    label=c("Homozygous Reference","Heterozygous","Homozygous Alternate","Missing"))








