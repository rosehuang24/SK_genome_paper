library(scales)
library(ggplot2)
library(dplyr)
library(ggalt)

col.list <- c("WLH"="red", 
              "TLF"="springgreen4", 
              "SK"="Orange",
              "WHYC"= "pink", 
              "DL"="deepskyblue1", 
              "YNLC"="yellow3", 
              "TBC"="lightblue", 
              "YVC"="violetred4", 
              "LX"="slateblue1", 
              "RJF"="grey34") 

level_order=c("WLH","TLF","SK","WHYC","DL","YNLC","TBC","YVC","LX","RJF", "GGS","GGJ","GJF")

dma<-read.delim("cat.txt", header = FALSE, col.names = c("label","x", "y")
levels(dma$label)

dma<-dma %>% arrange(x)#VERY IMPORTANT *crying face

p<-ggplot(dma, aes(x,y, group=label,color=factor(label, level=level_order)))+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)),
                limits = c(10^2.1,1e7)) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  annotation_logticks(side="l") +
  annotation_logticks(side="b") +
  theme_classic() +
  theme(legend.title=element_blank(),
        legend.justification=c(1,0), 
        legend.position=c(0.9,0.07),
        legend.key.size = grid::unit(1.5, "lines"),
        legend.text = element_text(size = 16))+
  scale_colour_manual(values = col.list,na.translate = FALSE)
 
#if you want to add points onlines (totally decrorative), thin the dma with like, retain 1 every 12 lines, and remember to keep the x=0 datapoint)                
#dt <- read.delim("thin.line12.txt", header = FALSE, col.names = c("label","x","y"))

p+geom_line(size=3, alpha=.8)+
#  geom_point(data=dt, aes(x,y, group=label,color=factor(label, level=level_order)), size=2.05)+#add scatter datapoints
#  geom_point()+
  labs(x="Generation (ago)",y="Ne")+
  theme(plot.title=element_text(size=20,face="bold", margin = margin(t = 20, b = 20)),
        axis.text=element_text(size=16, face="bold"), 
        axis.title = element_text(size=20,face="bold",margin = margin(t = 0, r = 10, b = 0, l = 10)),
        axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 10)),
        axis.title.x = element_text(margin = margin(t = 10, r = 10, b = 0, l = 10)))



  
