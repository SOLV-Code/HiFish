# Setting Up
library(tidyverse)
library("devtools")
devtools::install_github("pbs-assess/rosettafish",force=FALSE)
library(rosettafish)

# Temporary local fix of the translation function
# see issue at https://github.com/SOLV-Code/FishLang/issues/3
source("CODE/Module_Translate.R")


# test the translation function

# local custom function (for now)
terms.use <- read.csv("DictionaryFiles/Hawaiian_Friedlanderetal2003.csv",stringsAsFactors = FALSE)
translate(c("Number"), terms = terms.use, from = "english", to = c("english", "hawaiian"),
          allow_missing = FALSE)




###############################
# Get the data

data.df <- read.csv("Examples/CoralReefFishAssemblages/Friedlanderetal2003_Table2.csv",stringsAsFactors = FALSE)
out.table <- data.df %>% select(Common.name,Frequency,Biomass, IRD)
write.csv(out.table,"Examples/CoralReefFishAssemblages/DisplayTable.csv",row.names = FALSE)



###############################
# Do the figures

# source the plotting functions
source("CODE/Module_CustomFigs.R")

# test the barplot
custom.barplot(data.df$IRD,labels=data.df$Common.name,xlab="IRD")
title(main="Dominant Species")
#custom.barplot(data.df$IRD,labels=NULL,xlab="IRD")
#custom.barplot(data.df$Frequency,labels=data.df$Common.name,xlab="Frequency")
#custom.barplot(data.df$Biomass,labels=data.df$Common.name,xlab="% of Biomass")

# test the tornadoplot
custom.tornadoplot(data.df[,c("Frequency","Biomass")],labels=data.df$Common.name,xlab="Percent")
title(main="Dominant Species")

# test the multiplot
custom.multiplot(data.df[,c("IRD","Frequency","Biomass")],labels=data.df$Common.name,
                 xlabs=c("Index of Relative Dominance","Frequency","Biomass"))


# generate the figure labels
labels.english <- data.df$Common.name
xlabs.in <- c("IRD","Frequency","Biomass")

for(lang.to in c("english","hawaiian")){

labels.use <- translate(labels.english, from = "english", to = lang.to, 
                             terms = terms.use,allow_missing = FALSE)
xlabs.use <- paste0(translate(xlabs.in, from = "english", to = lang.to, 
                       terms = terms.use, allow_missing = FALSE),
                      c(" "," (%)"," (%)"))
title.use <- paste(translate("Index of Relative Dominance", from = "english", to = lang.to, 
                       terms = terms.use),
                   "(",translate("IRD", from = "english", to = lang.to, terms = terms.use),
                   "=", translate("Frequency", from = "english", to = lang.to, terms = terms.use),
                  "*", translate("Biomass", from = "english", to = lang.to, terms = terms.use),
                  ")")


png(filename = paste0( "Examples/CoralReefFishAssemblages/Plot_",lang.to,".png"),
    width = 480*4, height = 480*3.7, units = "px", pointsize = 14*4, bg = "white",  res = NA)
custom.multiplot(data.df[,c("IRD","Frequency","Biomass")],labels=labels.use,
                 xlabs=xlabs.use)
title(main=title.use,outer=TRUE,line=-2,col.main="darkblue" )
dev.off()


}


