# Packages
library(tidyr)
library(dplyr)
library(survival)
library(ggplot2)
library(RColorBrewer)


#Creating the data set from multiple files

load("FinalCore2009.rdat")
data2009 <- temp

#Eliminating the columns not common across data files over the years
data2009 <- data2009[,(-150)]
data2009 <- data2009[,(-150)]

#Process repeated individually for remaining data files due to different columns in each year

#2010
load("WA_SIDC_2010_CORE.rdat")
data2010 <- temp
data2010 <- data2010[,-125]
data2010 <- data2010[,(-150)]
data2010 <- data2010[,(-150)]


#2011
load("WA_SIDC_2011_CORE.rdat")
data2011 <- temp
data2011 <- data2011[,(-103)]
data2011 <- data2011[,(-103)]
data2011 <- data2011[,(-111)]
data2011 <- data2011[,(-111)]
data2011 <- data2011[,(-119)]
data2011 <- data2011[,(-119)]
data2011 <- data2011[,(-122)]
data2011 <- data2011[,(-122)]
data2011 <- data2011[,(-125)]
data2011 <- data2011[,(-143)]
data2011 <- data2011[,(-150)]
data2011 <- data2011[,(-150)]


#2012
load("WA_SIDC_2012_CORE.rdat")
data2012 <- temp
data2012 <- data2012[,(-125)]
data2012 <- data2012[,(-143)]
data2012 <- data2012[,(-150)]
data2012 <- data2012[,(-150)]


#2013
load("WA_SIDC_2013_CORE.rdat")
data2013 <- temp


data2013 <- data2013[,(-8)]
data2013 <- data2013[,(-125)]
data2013 <- data2013[,(-143)]
data2013 <- data2013[,(-150)]

#Renaming column names
colnames(data2013)[153] <- "pl_rucc2003"
colnames(data2013)[154] <- "pl_uic2003"


rm(temp)

#Exporting cleaned up data

write.csv(data2009, file = "data2009.csv", row.names = FALSE)
write.csv(data2010, file = "data2010.csv", row.names = FALSE)
write.csv(data2011, file = "data2011.csv", row.names = FALSE)
write.csv(data2012, file = "data2012.csv", row.names = FALSE)
write.csv(data2013, file = "data2013.csv", row.names = FALSE)