setwd("~/Desktop/Stats/TREEMIX/")
library(ggplot2)

df<-read.delim("input4_plots/residual_f")

ylim.resid <-c(0,100)
ylim.f<-c(0.9,1.0)
b<-diff(ylim.resid)/diff(ylim.f)
a<-b*(ylim.resid[1]-ylim.f[1])


p<-ggplot(df, aes(x=Mig))+  
  theme_light()+
  scale_x_continuous("Migration", breaks = 0:9)+
  theme(plot.title=element_text(size=20,face="bold", margin = margin(t = 20, b = 20)),
        axis.text.y=element_text(size=12,face="bold"), 
        axis.text.y.right=element_text(color="indianred3",size=12,face="bold"), 
        axis.text.x = element_text(size=12,face="bold"),
        #axis.title = element_text(size=16,margin = margin(t = 0, r = 10, b = 10, l = 10)),
        axis.title.y = element_text(color="slategray4",size=16,face="bold", margin = margin(t = 10, r = 10, b = 10, l = 10)),
        axis.title.x = element_text(size=16, face="bold",margin = margin(t = 10, r = 10, b = 10, l = 10)),
        axis.title.y.right= element_text(color="indianred3",size=16,face="bold", margin = margin(t = 10, r = 10, b = 10, l = 10)))
  

  


p+geom_line(aes(y=Residual), color="slategray4", size = 1.5, alpha =.8)+
  geom_line(aes(y= a + f*b), color = "indianred3", size = 1.5,alpha =.8)+
  geom_point(aes(y= a + f*b),color = "indianred3", size=2)+
  geom_point(aes(y=Residual),color="slategray4", size=2)+
  scale_y_continuous("Residual", sec.axis = sec_axis(~ (. - a)/b, name = "Model Fitting"),)

