setwd("~/Desktop/Stats/LD_107_0.9/")
read.table("out.WLH")->EWLH
read.table("out.TLF")->ETLF
read.table("out.TBC")->ETBC
read.table("out.LX")->ELX
read.table("out.DL")->EDL
read.table("out.YNLC")->EYNLC
read.table("out.YVC")->EYVC
read.table("out.SK")->ESK
read.table("out.RJF")->ERJF
read.table("out.luo")->Eluo
read.table("out.WHYC")->EWHYC
read.table("out.Clean")->EClean



setwd("~/Desktop/Stats/LD_107_0.9/input4/")

read.table("ldgraph.108.input.4.50kb.DULO")->EDL
read.table("ldgraph.108.input.4.50kb.WLH")->EWLH
read.table("ldgraph.108.input.4.50kb.TLF")->ETLF
read.table("ldgraph.108.input.4.50kb.TBC")->ETBC
read.table("ldgraph.108.input.4.50kb.LX")->ELX
read.table("ldgraph.108.input.4.50kb.YNLC")->EYNLC
read.table("ldgraph.108.input.4.50kb.YVC")->EYVC
read.table("ldgraph.108.input.4.50kb.SK")->ESK
read.table("ldgraph.108.input.4.50kb.RJF")->ERJF
read.table("ldgraph.108.input.4.50kb.WHYC")->EWHYC


par(mar = c(5,7,5,5))

plot(EWLH[,1]/1000,EWLH[,2],
     type="l",
     cex.axis = 0.8,
     cex.lab=1.35,
     col="red",
#     main="LD decay",
     xlab="Distance(Kb)",
     xlim=c(0,50),
     ylim=c(0,0.6),
     ylab=expression(r^{2}),
     font.lab=2,
     font=2,
     bty="n",lwd=2)
#lines(EClean[,1]/1000,EClean[,2],col="black",lwd=4, lty=1)
#lines(Eluo[,1]/1000,Eluo[,2],col="black",lwd=4, lty=4)
lines(ETLF[,1]/1000,ETLF[,2],col="springgreen4",lwd=2)
lines(ESK[,1]/1000,ESK[,2],col="Orange",lwd=2)
lines(EWHYC[,1]/1000,EWHYC[,2],col="pink",lwd=2)
lines(EDL[,1]/1000,EDL[,2],col="deepskyblue1",lwd=2,lty=5)
lines(ELX[,1]/1000,ELX[,2],col="slateblue1",lwd=2,lty=5)
lines(EYVC[,1]/1000,EYVC[,2],col="violetred4",lwd=2)
lines(ETBC[,1]/1000,ETBC[,2],col="lightblue",lwd=2)
lines(EYNLC[,1]/1000,EYNLC[,2],col="yellow3",lwd=2, lty=5)

lines(ERJF[,1]/1000,ERJF[,2],col="grey34",lwd=2)
#legend("topright",c("WLH","TLF","YNLC","YVC","TBC","LX","WHYC","DL","SK","RJF","SKluo","SKClean"),col=c("tomato3","springgreen4","yellow4","violetred4","turquoise4","red","pink","steelblue4","Orange","darkgrey","black","black"),cex=1,lty=c(1,1,1,1,4,4,1,3,1,1,4,1),bty="n",lwd=2)
#legend("topright",c("WLH","SK_Clean","SK_Luo","TLF","SK_all","WHYC","DULO","YNLC","TBC","YVC","LX","RJF"),col=c("tomato3","black","black","springgreen4","Orange","pink","steelblue4","yellow4","turquoise4","violetred4","red","darkgrey"),cex=1,lty = c(1,1,4,1,1,1,3,1,4,1,4,1),bty="n",lwd=2)

#legend(x=3, y=0.6,c("WLH","TLF","SK","WHYC","DULO","YNLC","TBC","YVC","LX","RJF"),col=c("tomato3","springgreen4","Orange","pink","deepskyblue1","yellow3","lightblue","violetred4","slateblue1","grey34"),cex=1.5,lty = c(1,1,1,1,3,1,4,1,4,1),bty="n",lwd=5)
#split them into two columns:
legend(x=29, y=0.6,c("WLH","TLF","SK","WHYC","DULO"),col=c("red","springgreen4","Orange","pink","deepskyblue1"),cex=1,text.font=2,lty = c(1,1,1,1,2),bty="n",lwd=2,seg.len=2)
legend(x=40, y=0.6,c("YNLC","TBC","YVC","LX","RJF"),col=c("yellow3","lightblue","violetred4","slateblue1","grey34"),cex=1,text.font=2,lty = c(2,1,1,2,1),bty="n",lwd=2,seg.len=2)


#legend("topright",c("WLH","SK_Huang","SK_Luo","TLF","YNLC","LX","RJF"),col=c("red","black","black","springgreen4","yellow4","red","grey"),cex=1,lty = c(1,1,4,1,1,4,1),bty="n",lwd=2)

plot(ETLF[,1]/1000,ETLF[,2],type="l",col="springgreen4",main="LD decay",xlab="Distance(Kb)",xlim=c(0,5),ylim=c(0.15,0.4),ylab=expression(r^{2}),bty="n",lwd=2)
lines(EDL[,1]/1000,EDL[,2],col="steelblue4",lwd=2)
lines(ESK[,1]/1000,ESK[,2],col="Orange",lwd=2)
lines(ELuo[,1]/1000,Eluo[,2],col="darkgrey",lwd=2)
lines(ELX[,1]/1000,ELX[,2],col="red",lwd=2)
lines(EYNLC[,1]/1000,EYNLC[,2],col="yellow4",lwd=2)

plot(EWLH[,1]/1000,EWLH[,2],type="l",col="pink",main="LD decay",xlab="Distance(Kb)",xlim=c(0,10),ylim=c(0.05,0.25),ylab=expression(r^{2}),bty="n",lwd=2)
legend("topright",c("WLH","TLF","YNLC","YVC","TBC","LX","WHYC","DL","SK","RJF","SKluo","SKClean"),col=c("tomato3","springgreen4","yellow4","violetred4","turquoise4","red","pink","steelblue4","Orange","darkgrey","black","black"),cex=1,lty=c(1,1,1,1,4,4,1,3,1,1,4,1),bty="n",lwd=2)

