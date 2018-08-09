rm(list=ls())
setwd("~/Documents/GC_speedup/CPU/Test_jacobian/code/Jacobian")
ss=readLines("gckpp_Jacobian.F90")
ind=grepl("lshen",ss)
ss2=ss[ind]
result=NULL
for(k in 1:length(ss2)){
ap=as.numeric(strsplit(ss2[k],split="[ ]+")[[1]][c(5,8)])
result=rbind(result,ap)
}
y=tapply(result[,2],result[,1],mean)


ss=readLines("logges")
ind=grepl("lshen",ss)
ss2=ss[ind]
result=NULL
for(k in 1:length(ss2)){
ap=as.numeric(strsplit(ss2[k],split="[ ]+")[[1]][c(5,8)])
result=rbind(result,ap)
}
y2=tapply(result[,2],result[,1],mean)


dev.new(width=5,height=2.8)
par(mai=c(0.6, 0.6, 0.25, 0.2), mgp=c(1.6, 0.4, 0), tcl=-0.2, ps=13)
plot(1:72,y,type="l",xlab="layers",ylab="time")
lines(1:72,y2,col=2)
legend("topright",c("with NMVOC","w/o NMVOC"),lty=1,col=c(1,2),text.col=c(1,2),bty="n")
title("Time spent by flexchem in different layers",font.main=1)