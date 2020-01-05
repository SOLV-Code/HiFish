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
#custom.barplot(data.df$Frequency,labels=data.df$Common.name,xlab="Frequency")
#custom.barplot(data.df$Biomass,labels=data.df$Common.name,xlab="% of Biomass")

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

# test the tornadoplot
custom.tornadoplot(data.df[,c("Frequency","Biomass")],labels=data.df$Common.name,xlab="Percent")
title(main="Dominant Species")

#####################

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


# test the multiplot
custom.multiplot(data.df[,c("IRD","Frequency","Biomass")],labels=data.df$Common.name,
                 xlabs=c("Index of Relative Dominance","Frequency","Biomass"))




# do the translations
library("devtools")
devtools::install_github("pbs-assess/rosettafish")
library(rosettafish)
terms.use <-read.csv("DictionaryFiles/Hawaiian_Friedlanderetal2003.csv",stringsAsFactors = FALSE) #,
                    #encoding = "UTF-8")





# generate the figures
labels.english <- data.df$Common.name

# NEED TO CALL IT "FRENCH" UNTIL THEY CHANGE IT IN THE PACKAGE....
labels.hawaiian <- rosettafish::trans(labels.english, from = "english", to = "french", 
                                      custom_terms = terms.use[,c("english","french")], allow_missing = FALSE)




png(filename = paste0( "Examples/CoralReefFishAssemblages/Plot_english.png"),
    width = 480*4, height = 480*3.7, units = "px", pointsize = 14*4, bg = "white",  res = NA)

custom.multiplot(data.df[,c("IRD","Frequency","Biomass")],labels=data.df$Common.name,
                 xlabs=c("IRD","Frequency (%)","Biomass (%)"))

title(main="Index of Relative Dominance (IRD = Freq * Biomass)",outer=TRUE,line=-2,col.main="darkblue" )

dev.off()


