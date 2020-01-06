# Example 1: Coral Reef Fish Assemblages

## Purpose

This example illustrates how to set up the translation function together with a custom
plotting function to quickly generate alternative versions of a figure (e.g. for reference handouts in different languages)

## Data Source

Table 2 from  [Friedlander *et al.* (2003)](http://cramp.wcc.hawaii.edu/Downloads/Publications/PRJ_friedlander_et_al_coral_reefs.pdf)  lists frequency, biomass, and index of relative dominance for the top 20 species of coral reef fish observed in 231 transects at 60 survey sites throughout the Hawaiian islands as part of the [Coral Reef Assessment and Monitoring Program (CRAMP)](http://cramp.wcc.hawaii.edu/).


**Common.name** |	**Frequency** |	**Biomass** | **IRD**
-- | -- | -- | --
Brown surgeonfish |	81.59 |	6.28 |	512.07
Black triggerfish |	36.82 |	13.25 |	487.72
Goldring surgeonfish |	62.76 |	6.52	 |408.95
Saddle wrasse |	99.58 |	3.4	 |338.27
Orangespine unicornfish |	49.37 |	4.39 |	216.65
Bullethead parrotfish |	39.33 |	3.95 |	155.29
Whitebar surgeonfish |	28.87 |	5.1 |	147.27
Redlip parrotfish |	23.01 |	4.42 |	101.68
Yellow Tang	34.31 |	2.68 |	92.1 |
Convict tang |	24.27 |	3.66	88.87 |
Orangeband surgeonfish |	31.38 |	2.72 |	85.23
Palenose parrotfish |	39.75 |	1.71 |	67.86
Spectacled parrotfish |	15.9 |	4.18 |	66.4
Sergeant Major |	17.57 |	3.42 |	60.13
Pacific Gregory |	69.46 |	0.76 |	52.83
Manybar goatfish |	48.95 |	0.87 |	42.38
Blue spot grouper |	23.43 |	1.75 |	40.99
Bluespine unicornfish |	9.62 |	3.58 |	34.42
Reef triggerfish |	34.73 |	0.96	 |33.28
Blackfin chromis |	48.12 |	0.59 |	28.29


## Output


### English Version


<img src="https://github.com/SOLV-Code/HiFish/blob/master/Examples/CoralReefFishAssemblages/Plot_english.png"
	width="600">


### Hawaiian Version

*Preliminary, pending refinement of the dictionary file*

<img src="https://github.com/SOLV-Code/HiFish/blob/master/Examples/CoralReefFishAssemblages/Plot_hawaiian.png"
	width="600">



## Code

The full script is [here](https://github.com/SOLV-Code/HiFish/blob/master/Examples/CoralReefFishAssemblages/Example1_GenerateFigures.R). The custom plotting functions are [here](https://github.com/SOLV-Code/HiFish/blob/master/CODE/Module_CustomFigs.R). The current version of the dictionary file is [here](https://github.com/SOLV-Code/HiFish/blob/master/DictionaryFiles/Hawaiian_Friedlanderetal2003.csv).

The key bits of code are:

```
# Setting Up
library(tidyverse)
library("devtools")
devtools::install_github("pbs-assess/rosettafish",force=FALSE)
library(rosettafish)
source("CODE/Module_CustomFigs.R") # get plotting function

# Temporary local fix of the translation function
# see issue at https://github.com/SOLV-Code/FishLang/issues/3
source("CODE/Module_Translate.R")

# get the data
data.df <- read.csv("Examples/CoralReefFishAssemblages/Friedlanderetal2003_Table2.csv",stringsAsFactors = FALSE)


# generate the figures

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
```





















