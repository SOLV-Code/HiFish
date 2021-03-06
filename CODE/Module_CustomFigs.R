custom.barplot <- function(values,labels,xlab="Value"){
# values = vector with numeric values
# labels = vector with text strings
# xlab = x axis label
  
n.species <- length(values)  
y.ticks <- 1:n.species
plot(1:5,1:5,type="n",xlim=c(0,max(values)),ylim=c(n.species,1),bty="n",axes=FALSE,
      xlab = xlab,ylab="") 
axis(1)

rect(0,y.ticks-0.5,values,y.ticks+0.5,col="lightblue",border="darkblue")
if(!is.null(labels)){text(0,y.ticks,labels=labels,adj=1.1,xpd=NA,col="darkblue")}
  
}


custom.tornadoplot <- function(values,labels,xlab="Value"){
  # values = data frame with 2 numeric values (plotted on same axis)
  # labels = vector with text strings
  # xlab = x axis label
  
  n.species <- dim(values)[1]  
  y.ticks <- 1:n.species
  plot(1:5,1:5,type="n",xlim=c(-max(values[,1]),max(values[,2])),ylim=c(n.species,1),bty="n",axes=FALSE,
       xlab = xlab,ylab="") 
  axis(1)

  print(par("usr"))
  rect(0,y.ticks-0.5,values[,2],y.ticks+0.5,col="lightblue",border="darkblue")
  rect(0,y.ticks-0.5,-values[,1],y.ticks+0.5,col="white",border="darkblue")
  if(!is.null(labels)){text(par("usr")[1],y.ticks,labels=labels,adj=1.1,xpd=NA,col="darkblue")}
  
}



custom.multiplot <-  function(values,labels,xlabs){
  # values = data frame with n numeric columns
  # labels = vector with text strings
  # xlabs = x axis label
  
n.panels <- dim(values)[2] + 1
  
layout(matrix(0:3,nrow=1),width=c(1,3,2,2))

par(mar=c(5,6,3,0))
custom.barplot(values[,1],labels=labels,xlab=xlabs[1])

par(mar=c(5,2,3,0))
for(i in 2:dim(values)[2]){
custom.barplot(values[,i],labels=NULL,xlab=xlabs[i])  
}   
  
}


