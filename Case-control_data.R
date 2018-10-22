# Packages
library(tidyr)
library(dplyr)
library(survival)
library(ggplot2)
library(RColorBrewer)



#Combine dxn (where n: 1- 25) in a column "diagnosis"
data_comb_diag_2009 <- unite(data2009,diagnosis,dx1,dx2,dx3,dx4,dx5,dx6,dx7,dx8,dx9,dx10,dx11,dx12,dx13,dx14,dx15,dx16,dx17,dx18,dx19,dx20,dx21,dx22,dx23,dx24,dx25, sep=",")

# MRSA column generated to indicate presence of MRSA (MRSA = TRUE)
data2009$mrsa <- rep(FALSE,nrow=data2009)
data2009$mrsa[grep("(?=.*04112)", data_comb_diag_2009$diagnosis, ignore.case = TRUE, perl = TRUE)] <- TRUE 

# Eczema column generated to indicate presence of Eczema (Eczema = TRUE)
data2009$ezcema <- rep(FALSE,nrow=data2009)
data2009$ezcema[grep("(?=.*6929)", data_comb_diag_2009$diagnosis, ignore.case = TRUE, perl = TRUE)] <- TRUE 

#Column created to set flag for matched pair to enable case control analysis
data2009$match.pair <- rep(NA, nrow(data2009))


# for loop to find controls in one data set
ix<-which(data2009$mrsa)
for(i in 1:200){
  temp.age <- data2009[ix[i],"age"]
  temp.female <- data2009[ix[i],"female"]
  temp.amonth <- data2009[ix[i],"amonth"]
  
  temp.ix <- which(data2009$age==temp.age & data2009$female==temp.female & data2009$amonth == temp.amonth)
  
  data2009[ix[i], "match.pair"] <- i
  data2009[sample(temp.ix, 1), "match.pair"] <- i
}

temp.data <- data2009[!is.na(data2009$match.pair),]

# Load data - HCUP data for the years 2009 - 2014
data_6_yrs <- read.csv("case_control_6_yrs.csv")

# Make year-specific case control
data_6_yrs$match.pair.unique <- as.numeric(paste0(data_6_yrs$match.pair,".",data_6_yrs$year))
