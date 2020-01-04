# Setting Up
library(tidyverse)


data.df <- read.csv("Examples/CoralReefFishAssemblages/Friedlanderetal2003_Table2.csv",stringsAsFactors = FALSE)


out.table <- data.df %>% select(Common.name,Frequency,Biomass, IRD)
write.csv(out.table,"Examples/CoralReefFishAssemblages/DisplayTable.csv",row.names = FALSE)

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

# test the barplot
custom.barplot(data.df$IRD,labels=data.df$Common.name,xlab="IRD")
title(main="Dominant Species")
#custom.barplot(data.df$IRD,labels=NULL,xlab="IRD")



custom.tornadoplot <- function(values,labels,xlab="Value"){
  # values = data frame with 2 numeric values (plotted on same axis)
  # labels = vector with text strings
  # xlab = x axis label
  
  n.species <- length(values)  
  y.ticks <- 1:n.species
  plot(1:5,1:5,type="n",xlim=c(-max(values[,1]),max(values[,2])),ylim=c(n.species,1),bty="n",axes=FALSE,
       xlab = xlab,ylab="") 
  axis(1)
  
  rect(0,y.ticks-0.5,values[,2],y.ticks+0.5,col="lightblue",border="darkblue")
  #if(!is.null(labels)){text(0,y.ticks,labels=labels,adj=1.1,xpd=NA,col="darkblue")}
  
}

custom.tornadoplot(data.df[,c("Frequency","Biomass")],labels=data.df$Common.name,xlab="Percent")
title(main="Dominant Species")


