setwd("/Users/yourhighness/Desktop/Stats/good_window_overlap/45273/")
library(ggplot2)
library(dplyr)
library(ggrepel)
library(RColorBrewer)


fair_cols <- c("#38170B","#BF1B0B", "#FFC465", "#66ADE5", "#252A52")

d <- read.delim("all.three.45273.x.r.f.bed", header = TRUE)

dg <-read.table("genes.overlaps", header=TRUE)

d$index <- NA

for (i in 1:nrow(d)){
  if((d[i, "Zfst"]>=3.35) & (d[i, "Zratio"]<=-3.05) & (d[i,"Zxpehh"]>=3.01)){
    d[i,]$index=1
  }else{
    d[i,]$index=0
  }
}

p<-ggplot(d,aes(x=Zratio,y=Zfst))

p+geom_point(aes(color=Zxpehh)) +
  geom_vline(xintercept = -3.05,linetype="dashed")+
  geom_hline(yintercept = 3.35,linetype="dashed")+
  scale_color_gradientn(colors=rev(fair_cols))+
  xlim(-17,17)+
  xlab("Z (pi-ratio)")+
  ylab("Z (Fst)")+
  theme_classic()+
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black", fill=NA, size=1),
        legend.position = c(0.9, 0.8),
        axis.text=element_text(size=12,face="bold"), 
        axis.title = element_text(size=20,face="bold",margin = margin(t = 20, r = 20, b = 20, l = 20)),
        legend.text=element_text(size=12),
        legend.title = element_text(size=14, face="bold"))+
  geom_point(data=d[d$index==1,], pch=21, fill=NA, size=1.5, colour="black", stroke=0.5,alpha=0.8)+
  geom_label_repel(data=dg, 
                   aes(Zratio, Zfst, label = genes,size = 2), 
                   box.padding = unit(0.8, 'lines'),
                   segment.color = 'slategray4',show.legend = FALSE)


#——————————————————————————————————————————————————————————————————————————————#
p<-ggplot(d,aes(x=Zxpehh,y=Zfst))

p+geom_point(aes(color=Zratio)) +
  geom_vline(xintercept = 3.3585,linetype="dashed")+
  geom_hline(yintercept = 3.0122,linetype="dashed")+
  #scale_color_gradient(low="blue", high="darkred")+
  scale_color_gradientn(colors=rainbow(3))+
  xlim(-10,15)+
  #xlab("Z (\u03C0 ratio)")+
  xlab("Z (XP-EHH)")+
  ylab("Z (Fst)")+
  theme_classic()+
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black", fill=NA, size=1),
        legend.position = c(0.1, 0.8))+
  geom_point(data=d[d$index==1,], pch=21, fill=NA, size=1.5, colour="black", stroke=0.5,alpha=0.8)+
  geom_label_repel(data=dg, 
                   aes(Zxpehh, Zfst, label = genes,size = 2), 
                   point.padding = unit(1.5, 'lines'), 
                   box.padding = unit(0.8, 'lines'),
                   segment.color = 'slategray4')



