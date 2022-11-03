library(ggplot2)
library(dplyr)
library(reshape2)

d<-read.delim("three_stats_3_67000000_69000000.input4.txt", header = FALSE, col.names=c("chrm","start","end","fst","ratio","xpehh"))
d <- melt(d, id=c("chrm","start","end"))
d<-d%>%rename(statistics = variable)
d$bin<-(d$start+d$end)/2

p <- ggplot(d, aes(bin,value,group=statistics,color=factor(statistics)))

pdf(file = "letter.version.pdf", width = 10,height =4) 

p+geom_line(size=1.2)+
  ylim(-6,7)+
  xlim(67550000,68245000)+
  theme_light()+
  labs(x='Chromosome Position', y='Z scores', title="Chromosome 3")+
  scale_color_manual(values=c("#56B4E9","#0072B2", "#D55E00"))+
  theme(plot.title=element_text(size=20,face="bold", margin = margin(t = 20, b = 20)),
        axis.text.y=element_text(size=12), 
        axis.text.x = element_text(size=10),
        axis.title = element_text(size=16,margin = margin(t = 0, r = 10, b = 0, l = 10)),
        axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 10)),
        axis.title.x = element_text(margin = margin(t = 10, r = 10, b = 0, l = 10)))+
  coord_cartesian(expand = FALSE)+
  geom_hline(yintercept=-5)+
  geom_segment(aes(x=67724491,y=-5,xend=67834185,yend=-5), color="#999999", size=4)+
  annotate("text", x=67790000, y=-4.3, label= "SOBP") + 
  annotate("segment", x = 67760000, xend = 67740000, y = -4.3, yend = -4.3 ,arrow = arrow(length = unit(.2,"cm")))+
  geom_segment(aes(x=67850522,y=-5,xend=67962399,yend=-5), color="#999999", size=4)+
  annotate("segment", x = 67930000, xend =67950000 , y = -4.3, yend = -4.3 ,arrow = arrow(length = unit(.2,"cm")))+ 
  annotate("text", x=67895000, y=-4.3, label= "PDSS2") + 
  geom_segment(aes(x=67820000,y=6.75,xend=67860000,yend=6.75), color="black", lty=2)+
  geom_segment(aes(x=67820000,y=-5,xend=67860000,yend=-5),color="black", lty=2)+
  geom_segment(aes(x=67820000,y=6.75,xend=67820000,yend=-5),color="black", lty=2)+
  geom_segment(aes(x=67860000,y=6.75,xend=67860000,yend=-5),color="black", lty=2)+
  theme(legend.title=element_blank(),
        legend.direction = "horizontal",
        legend.justification=c(1,-3.25), 
        legend.position=c(0.99,0.07),
        legend.key.size = grid::unit(1.8, "lines"),
        legend.text = element_text(size = 10))+
  scale_color_manual(values=c("#56B4E9","#0072B2", "#D55E00"), labels = c("Z(Fst)","Z(pi_ratio)","Z(xp-ehh)"))
dev.off()


