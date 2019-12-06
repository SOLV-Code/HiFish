# HiFish

*E komo mai / Welcome*

Hawaiian language pack for the *rosettafish* package

## Basic Idea

The [rosettafish package](https://github.com/pbs-assess/rosettafish) is designed to automate the translation of fisheries-related words and short phrases, so that multilingual versions of technical versions can be easily generated in R. *rosettafish* has a built in dictionary for English, French, and Inuktitut, but also allows for customized dictionary files.

The purpose of this repository is to build English-Hawaiian dictionary files and develop some illustrations of how to use them. 

*HiFish* is part of the [FishLang](https://github.com/SOLV-Code/FishLang) family of language extensions, which currently also includes [GaelFish](https://github.com/SOLV-Code/GaelFish) (Gàidhlig / Scottish Gaelic) and [FinnFish](https://github.com/SOLV-Code/FinnFish) (Suomi / Finnish).


## Repository Structure

This repository has 2 main folders:

* *DictionaryFiles*: *.csv* files with  translations of words and short phrases. These files must include one column for each language. Optional columns can be added to help with managing the content and grouping terms for markdown-based summary handouts. 
* *Examples*: R code, input data, and outputs for the examples summarized below



## How to Contribute

The [main FishLang repository](https://github.com/SOLV-Code/FishLang) is where the general structure of the individual language packs is being developed and coordinated. You can leave general comments, implementation suggestions, and requests for other language packs on the [FishLang Issues Page](https://github.com/SOLV-Code/FishLang/issues).

Any questions, corrections, or suggestions specific to the *Hawaiian* language pack should go up on the [HiFish Issues Page](https://github.com/SOLV-Code/HiFish/issues)



## Getting Started



### Install *rosettafish*


```
library("devtools")
devtools::install_github("pbs-assess/rosettafish")
library(rosettafish)
```


### Test the translation function

```

# Read in the custom dictionary
terms.use <-read.csv(url("DATA/BaseData/BasicDictionary_Hawaiian.csv",stringsAsFactors = FALSE)

#test the translation function
rosettafish::trans("Overfishing Profile", from = "english", to = "french", 
                   custom_terms = terms.use, allow_missing = FALSE)


```


## Worked Examples


### Plot Examples




### Vocabulary Handout Examples