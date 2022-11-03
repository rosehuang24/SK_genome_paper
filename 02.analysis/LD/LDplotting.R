setwd("~/Desktop/Stats/LD_107_0.9/input4/")

read.table("ldgraph.107.input.4.50kb.DULO")->EDL
read.table("ldgraph.107.input.4.50kb.WLH")->EWLH
read.table("ldgraph.107.input.4.50kb.TLF")->ETLF
read.table("ldgraph.107.input.4.50kb.TBC")->ETBC
read.table("ldgraph.107.input.4.50kb.LX")->ELX
read.table("ldgraph.107.input.4.50kb.YNLC")->EYNLC
read.table("ldgraph.107.input.4.50kb.YVC")->EYVC
read.table("ldgraph.107.input.4.50kb.SK")->ESK
read.table("ldgraph.107.input.4.50kb.RJF")->ERJF
read.table("ldgraph.107.input.4.50kb.WHYC")->EWHYC


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

#split them into two columns:
legend(x=29, y=0.6,c("WLH","TLF","SK","WHYC","DULO"),col=c("red","springgreen4","Orange","pink","deepskyblue1"),cex=1,text.font=2,lty = c(1,1,1,1,2),bty="n",lwd=2,seg.len=2)
legend(x=40, y=0.6,c("YNLC","TBC","YVC","LX","RJF"),col=c("yellow3","lightblue","violetred4","slateblue1","grey34"),cex=1,text.font=2,lty = c(2,1,1,2,1),bty="n",lwd=2,seg.len=2)


