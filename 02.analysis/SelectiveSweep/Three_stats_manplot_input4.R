setwd("~/Desktop/Stats/good_window_overlap/45273/")
#setwd("/Users/yourhighness/Desktop/Stats/good_window_overlap/SKvs75DC")
library(ggplot2)
library(dplyr)
library(ggrepel)

#CHROM	BIN_START	BIN_END	N_VARIANTS	WEIGHTED_FST	MEAN_FST

#do <-read.delim("", header = FALSE, col.names = c("chrm","start","end"))

df<- read.delim("all.three.45273.x.r.f.bed", header = FALSE, col.names = c("chrm","start","end","x","Zxpehh","ratio","Zratio","fst","Zfst"))
df$chrm=factor(as.character(df$chrm), levels=paste0(c(1:28)))
levels(df$chrm)

df <- df[order(df[,1]),]

#df$lr <- -log(df$ratio)
#df<-df %>% filter_all(all_vars(!is.infinite(.)))
#df$Zlr<-(df$lr-mean(df$lr))/sd(df$lr)
#df$rr<- 1/df$ratio
#df<-df %>% filter_all(all_vars(!is.infinite(.)))

#df$Zrr<-(df$rr-mean(df$rr))/sd(df$rr)

d <-data.frame(chr = df$chrm, bp = df$start, ZFst = df$Zfst, Zratio = df$Zratio, Zxp_ehh = df$Zxpehh)

#sum(d$Fst<0)
#d$Zfst <- (d$Fst-mean(d$Fst))/sd(d$Fst)



d$pos <- NA
d$index <- NA

ind = 0
for (i in unique(d$chr)){
  ind = ind + 1
  d[d$chr==i,]$index = ind
}

lastbase = 0
for(i in unique(d$index)){
  if(i==1){
    d[d$index==i, ]$pos=d[d$index==i, ]$bp
  } else {
    lastbase=lastbase+tail(subset(d,index==i-1)$bp,1)
    d[d$index==i, ]$pos=d[d$index==i, ]$bp+lastbase
  }
}

#d$lastbase <- d$pos-d$bp
#print(unique(d$lastbase))
#cat(unique(d$lastbase), file = "laste_base.txt", sep = '\n')


d$cc <-NA
for (i in unique(d$index)){
  d[d$index==i,]$cc = i%%2+1} 

#d$clr<-NA

col.list=c("sandybrown","royalblue3")
h=3.3528#Fst
h=3.0119#x

h=-3.0573
#plot dimension:
#pdf(file = "Manplot_ratio.pdf", width = 20,height =6) 




############################################################
##########______________Ratio PNG_______________######
png(file = "Manplot_ratio.png", width = 2000,height =600) 
#pdf(file = "Manplot_ratio.pdf", width = 20, height = 8)
h=-3.05#pi

p<-ggplot(d,aes(pos,Zratio))
p+geom_point(color=col.list[as.factor(d$cc)]) + 
  scale_x_continuous(expand=c(0.01,0.01)) +
  theme_light()+
  ylim(c(-10,16))+
#  labs(x='Chromosome Position', y='Z(pi_ratio)') +
  labs(x=' ', y=expression("Z"~Pi~"_ratio")) +
  geom_hline(yintercept = h, linetype="dashed", col="darkred", size=1.5)+
  #scale_y_continuous()+
  geom_text(aes(0, h ,label = h, hjust = 2), size = 4, col="darkred")+
  coord_cartesian(clip = 'off') +
  theme(axis.text.x = element_blank(),
        axis.text=element_text(size=16), 
        axis.title = element_text(size=30,face="bold",
                                  margin = margin(t = 20, r = 20, b = 20, l = 20)),
        plot.margin = unit(c(2,2,2, 2), "cm"))

dev.off()

############################################################
######_________________Fst_________________##############
h=3.35#Fst

png(file = "Manplot_fst.png", width = 2000,height =600) 
#pdf(file = "Manplot_fst.pdf", width = 20, height = 8)

p<-ggplot(d,aes(pos,ZFst))
p+geom_point(color=col.list[as.factor(d$cc)]) + 
  scale_x_continuous(expand=c(0.01,0.01)) +
  theme_light()+
  ylim(c(-4,12))+
  labs(x=' ', y='Z(FST)') +
  geom_hline(yintercept = h, linetype="dashed", col="darkred", size=1.5)+
  #scale_y_continuous()+
  geom_text(aes(0, h ,label = h, vjust = 2, hjust = 1.5), size =6, col="darkred")+
  coord_cartesian(clip = 'off') +
  theme(axis.text.x = element_blank(),
        axis.text=element_text(size=16), 
        axis.title = element_text(size=30,face="bold",
                                  margin = margin(t = 20, r = 20, b = 20, l = 30)),
        plot.margin = unit(c(2,2,2, 2), "cm"))

dev.off()


############################################################
######_________________xpehh_________________##############
h=3.01#x

#png(file = "Manplot_xpehh.png", width = 2000,height =600) 
pdf(file = "Manplot_xpehh.pdf", width = 20, height = 8)

p<-ggplot(d,aes(pos,Zxp_ehh))
p+geom_point(color=col.list[as.factor(d$cc)]) + 
  scale_x_continuous(expand=c(0.01,0.01)) +
  theme_light()+
  labs(x=' ', y='Z (XP-EHH)') +
  geom_hline(yintercept = h, linetype="dashed", col="darkred", size=1.5)+
  #scale_y_continuous()+
  geom_text(aes(0, h ,label = h, hjust = 1.6), size =6, col="darkred")+
  coord_cartesian(clip = 'off') +
  theme(axis.text.x = element_blank(),
        axis.text=element_text(size=16), 
        axis.title = element_text(size=30,face="bold",
                                  margin = margin(t = 20, r = 20, b = 20, l = 20)),
        plot.margin = unit(c(2,2,2, 2), "cm"))

dev.off()

############################################################
######_________________Distribution_________________##############

############################################################
######_________________Fst_________________##############

pdf(file = "Dis_Zfst.pdf", width = 10,height =8) 
#png(file = "Dis_Zfst.png", width = 1000,height =600) 
h=3.35#Fst

p<-ggplot(d,aes(ZFst))
p+geom_histogram(position="identity", binwidth = 0.1) +  
  labs(x='Z(FST)') +
  xlim(-6,12)+
  geom_vline(xintercept = h, linetype="dashed", col="darkred")+
  geom_text(aes(0, h ,label = h, hjust =  -3.5, vjust=-15), size =6, col="darkred")+
  theme_light()+
  theme(axis.text=element_text(size=16), 
        axis.title = element_text(size=25,face="bold",
                                  margin = margin(t = 20, r = 20, b = 20, l = 20)),
        plot.margin = unit(c(2,1, 1, 1), "cm"))
  

dev.off()

############################################################
##########______________Ratio PNG_______________######
pdf(file = "Dis_Zratio.pdf", width = 10,height =8) 
#png(file = "Dis_Zratio.png", width = 1000,height =600) 
h=-3.05#pi

p<-ggplot(d,aes(Zratio))
p+geom_histogram(position="identity", binwidth = 0.1) +  
  labs(x='Z( Pi ratio)') +
  xlim(-10,16)+
  geom_vline(xintercept = h, linetype="dashed", col="darkred")+
  geom_text(aes(0, h ,label = h, hjust = 3, vjust=-15), size =6, col="darkred")+
  theme_light()+
  theme(axis.text=element_text(size=16), 
        axis.title = element_text(size=25,face="bold",
                                  margin = margin(t = 20, r = 20, b = 20, l = 20)),
        plot.margin = unit(c(2,1, 1, 1), "cm"))


dev.off()

############################################################
######_________________xpehh_________________##############
pdf(file = "Dis_Zxpehh.pdf", width = 10,height =8) 
#png(file = "Dis_Zxpehh.png", width = 1000,height =600) 
h=3.01#x

p<-ggplot(d,aes(Zxp_ehh))
p+geom_histogram(position="identity", binwidth = 0.1) +  
  labs(x='Z (XP-EHH)') +
  geom_vline(xintercept = h, linetype="dashed", col="darkred")+
  geom_text(aes(0, h ,label = h, hjust =  -2.5, vjust=-15), size =6, col="darkred")+
  theme_light()+
  theme(axis.text=element_text(size=16), 
        axis.title = element_text(size=25,face="bold",
                                  margin = margin(t = 20, r = 20, b = 20, l = 20)),
        plot.margin = unit(c(2,1, 1, 1), "cm"))


dev.off()
