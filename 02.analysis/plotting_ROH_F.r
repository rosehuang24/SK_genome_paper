setwd("~/Desktop/Stats/combined_roh_f/")
library(ggplot2)
library(ggsignif)
library(tidyr)
library(dplyr)

#what you need is a file with breed, individuals, F value (see /F/ folder) and total ROH lengt for each indivudal (see /ROH/ folder)
#this file has most engative TBC removed.however, either way the results didn't change much.
df<-read.delim("breed.indv.f.rohMB.txt", header=F, col.names = c("breed","indv","F","ROH"))


df$Fgroup_mean <- ave(df$F, df$breed)
df$Rgroup_mean <- ave(df$ROH, df$breed)

ylim.F<-c(0,0.8)
ylim.ROH<-c(0,750)
b<-diff(ylim.F)/diff(ylim.ROH)
a<-b*(ylim.F[1]-ylim.ROH[1])

level_order <- c('RJF','TLF','WHYC','YNLC','DULO',"YVC",'TBC','LX','SK','WLH')


d<-df%>%mutate(ROH = ROH*b+a)%>%
  pivot_longer(cols = c(F,ROH)) %>%
  mutate(breed = factor(breed, levels = level_order))


pdf(file = "f_roh.pdf", width = 14,height =8) 


f<-ggplot(d, aes(x=factor(breed,level_order)))

f+geom_boxplot(aes(y=value, color=name),lwd=1,outlier.shape = NA)+
  geom_point(aes(y=value, color=name),position=position_jitterdodge(dodge.width=0.9))+
  scale_color_manual(values = c(F = "dodgerblue3", ROH = "coral3")) +
  scale_y_continuous("F", sec.axis = sec_axis(~ (. - a)/b, name = expression("ROH (Mb)")))+
  theme_classic()+
  theme(axis.text=element_text(size=16,face="bold"), 
        axis.title = element_text(size=26),
        axis.text.y.left = element_text(color = "dodgerblue3"),
        axis.title.y.left = element_text(color = "dodgerblue3",margin = margin(t = 0, r = 20, b = 0, l = 20)),
        axis.text.y.right = element_text(color = "coral3"),
        axis.title.y.right = element_text(color="coral3", margin = margin(t = 0, r = 20, b = 0, l = 20)),
        axis.title.x=element_blank(), 
        legend.direction = "horizontal",
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.text = element_text(size=16),
        plot.margin = unit(c(2,1, 1, 1), "cm"))
  
dev.off()




######################
#make table for significance
#####################
library(tidyr)
df.av <- aov(F ~ breed , data = df)
res <- TukeyHSD(df.av, "breed", ordered = TRUE)
tk<-as.data.frame(res$breed)
tk <- tibble::rownames_to_column(tk, "comparisons")
dc<-separate(data = tk, col = comparisons, into = c("X1", "X2"), sep = "-")
colnames(dc) <- c("X1","X2","diff","lower","upper","p_adj")

dc<-dc%>%select("X1","X2","p_adj")

dc <- spread(dc, X1, p_adj)

write.table(dc,file="input.4.p_adj_TK_f.csv", sep=',', na="")


#########################
#make letters for Tukey Kramer:
########################
library(multcompView)

Finb <- read.table("input.4.combined_f_rohMB.txt", header=FALSE, col.names = c("breed","indv","F","ROH"))

model=lm( Finb$ROH ~ Finb$breed )
ANOVA=aov(model)

TUKEY <- TukeyHSD(x=ANOVA, 'Finb$breed', conf.level=0.95)

Tukey.levels <- TUKEY[["Finb$breed"]][,4]
Tukey.labels <- data.frame(multcompLetters(Tukey.levels)['Letters'])
Tukey.labels#$breed=rownames(Tukey.labels)
#Tukey.labels=Tukey.labels[order(Tukey.labels$breed) , ]

