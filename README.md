# HiFish

*E komo mai / Welcome*

Hawaiian language pack for the *rosettafish* package

## Basic Idea

The [rosettafish package](https://github.com/pbs-assess/rosettafish) is designed to automate the translation of fisheries-related words and short phrases, so that multilingual versions of technical versions can be easily generated in R. *rosettafish* has a built in dictionary for English, French, and Inuktitut, but also allows for customized dictionary files.

The purpose of this repository is to build English-Hawaiian dictionary files and develop some illustrations of how to use them. 

*HiFish* is part of the [FishLang](https://github.com/SOLV-Code/FishLang) family of language extensions, which currently also includes [GaelFish](https://github.com/SOLV-Code/GaelFish) (Gàidhlig / Scottish Gaelic) and [FinnFish](https://github.com/SOLV-Code/FinnFish) (Suomi / Finnish).

The [FishLang](https://github.com/SOLV-Code/FishLang) 


## Repository Structure

This repository has 3 main folders:

* *DictionaryFiles* :
* *Scripts*:
* *Output*:


## Technical Details



### Install


```
library("devtools")
devtools::install_github("pbs-assess/rosettafish")
library(rosettafish)
```


### Testing

```

# Read in the custom dictionary
terms.use <-read.csv(url("DATA/BaseData/BasicDictionary_Hawaiian.csv",stringsAsFactors = FALSE)

#test the translation function
rosettafish::trans("Overfishing Profile", from = "english", to = "french", 
                   custom_terms = terms.use, allow_missing = FALSE)


```


### Plot Example




### Vocabulary Handout Example