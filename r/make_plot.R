require(viridis)
require(plotly)
require(dplyr)
bm <- 1
par(las=1,bty="n"); xlim <- c(-5,5);ylim <- c(0,0.5)
set.seed(12)
N <- 2000
rr <- rnorm(N); rr2 <- rnorm(N^2); rr3 <- rnorm(N+0.3)
rrd <- density(rr);rrd2 <- density(rr2);rrd3 <- density(rr3)
main <- paste0(N," points in space");xlab <- "Points in space"
if(bm==1){
  layout(matrix(c(rep(1,3),2:4), 2, 3, byrow = TRUE));sc <- 1
  plot(rr,las=1,bty="n",col=adjustcolor(viridis(N),0.5),pch=20,cex=runif(10,1,5),
       main=main,xlab=xlab)
  for(r in list(rrd,rrd2,rrd3)){
   plot(r,xlim=xlim,ylim=ylim,main="")
    polygon(r,col=adjustcolor(viridis(250)[sc],0.5),border=viridis(250)[sc]);sc <- sc+100}
}else{par(mfrow=c(1,1))
  plot(rr,las=1,bty="n",col=adjustcolor(viridis(N),0.5),pch=20,cex=runif(10,1,5),
       main=main,xlab=xlab)}

