# Packages
library(tidyr)
library(dplyr)
library(survival)
library(ggplot2)
library(RColorBrewer)


# Research Question 1: How often does eczema diagnosis co-occur with MRSA, over the years 2009-2014, among hospitalized patients in Washington?
# Conditional logistic regression
mod.1 <- clogit(mrsa ~ eczema + strata(match.pair.unique), data=data_6_yrs, method="approximate")

summary(mod.1)
exp(confint(mod.1))

#Research Question 2: Is MRSA diagnosed more often in patients with skin infections or patients who have undergone surgical procedures?
mod.2 <- clogit(mrsa ~ orproc + strata(match.pair.unique), data=data_6_yrs, method="approximate")
summary(mod.2)
exp(confint(mod.2))

mod.3 <- clogit(mrsa ~ eczema + orproc + strata(match.pair.unique), data=data_6_yrs, method="approximate" )
summary(mod.3)
exp(confint(mod.3))

mod.4 <- clogit(mrsa ~ eczema + orproc + skin_infection + strata(match.pair.unique), data=data_6_yrs, method="approximate" )
summary(mod.4)
exp(confint(mod.4))


# Research question 3: Are incidents of Eczema and MRSA co-occurence more frequent in hospitalized children (0-3 yrs) or older patients (about 60 yrs)?
# Filter childern & adults from case control data for research 

children_3 <- filter(data_6_yrs, age <=3)
adults <- filter(data_6_yrs, age >= 60)

mod.children <- clogit(mrsa ~ eczema + strata(match.pair.unique), data=children_3, method="approximate" )
summary(mod.children)

mod.adults <- clogit(mrsa ~ eczema + strata(match.pair.unique), data = adults, method = "approximate")
summary(mod.adults)


#  Plot data prep
age_graph <- data_6_yrs %>%
  group_by(age,mrsa) %>%
  filter(mrsa == TRUE) %>%
  summarize(total.count=n())

surgery_graph <- data_6_yrs %>%
  group_by(age,orproc) %>%
  filter(orproc== 1) %>%
  summarize(total.count=n())

skin_infection_graph <- data_6_yrs %>%
  group_by(age,skin_infection) %>%
  filter(skin_infection == TRUE) %>%
  summarize(total.count=n())

eczema_graph <- data_6_yrs %>%
  group_by(age,eczema) %>%
  filter (eczema == TRUE) %>%
  summarize(total.count=n())


# Plot age vs mrsa freq / age vs. orproc freq  
plot(age_graph$age,age_graph$total.count, type="o", xlab="Age", ylab = "Occurrence")
points(surgery_graph$age, surgery_graph$total.count, type = "o", col=2)

# Adding  age in eczema graph so that age's considered are uniform across age_graph, eczema_graph and surgery_graph. 
# The occurrence of eczema for these ages remains zero. 
temp <- age_graph$age[which(!age_graph$age%in%eczema_graph$age)]
eczema_graph_full <- rbind(data.frame(eczema_graph), cbind("age"=temp, "eczema"=rep(T, length(temp)), "total.count" = rep(0, length(temp))))
eczema_graph_full <- eczema_graph_full[order(eczema_graph_full$age),]
points(eczema_graph_full$age, eczema_graph_full$total.count, type = "o", col=4)
lines(age_graph$age, age_graph$total.count + eczema_graph_full$total.count)
legend("topright",legend=c("MRSA","Surgery"), lty=c(1,1), col = c(2,"black"))


plot(surgery_graph$total.count, age_graph$total.count)
abline(0,1)
summary(lm(age_graph$total.count ~ surgery_graph$total.count))

tab <- table("mrsa"=data_6_yrs$mrsa, "orproc"=data_6_yrs$orproc)
tab/sum(tab)


#Plot age vs. eczema freq / age vs. skin infection freq
plot(skin_infection_graph$age,skin_infection_graph$total.count, type = "o", col='red', ylim=c(0,40))
points(eczema_graph$age,eczema_graph$total.count, type = "o", col='green')

# Additional questions - Top primary diagnosis associated with MRSA

case_control <- data_6_yrs

valid_dx1_2009<- case_control[(!is.na(case_control$dx1)) & case_control$mrsa== TRUE & case_control$ayear== "2009", ]
dx1_groups_2009<- valid_dx1_2009 %>%
  group_by(dx1) %>%
  summarise(count= n()) %>%
  filter(count>150)
dx1_desc_2009<- arrange(dx1_groups_2009, desc(count))
dx1_desc_2009$pct <- (dx1_desc_2009$count/sum(dx1_desc_2009$count))*100


valid_dx1_2010<- case_control[(!is.na(case_control$dx1)) & case_control$mrsa== TRUE & case_control$ayear== "2010", ]
dx1_groups_2010<- valid_dx1_2010 %>%
  group_by(dx1) %>%
  summarise(count= n()) %>%
  filter(count>150)
dx1_desc_2010<- arrange(dx1_groups_2010, desc(count))
dx1_desc_2010$pct <- (dx1_desc_2010$count/sum(dx1_desc_2010$count))*100

valid_dx1_2011<- case_control[(!is.na(case_control$dx1)) & case_control$mrsa== TRUE & case_control$ayear== "2011", ]
dx1_groups_2011<- valid_dx1_2011 %>%
  group_by(dx1) %>%
  summarise(count= n()) %>%
  filter(count>150)
dx1_desc_2011<- arrange(dx1_groups_2011, desc(count))
dx1_desc_2011$pct <- (dx1_desc_2011$count/sum(dx1_desc_2011$count))*100

valid_dx1_2012<- case_control[(!is.na(case_control$dx1)) & case_control$mrsa== TRUE & case_control$ayear== "2012", ]
dx1_groups_2012<- valid_dx1_2012 %>%
  group_by(dx1) %>%
  summarise(count= n()) %>%
  filter(count>150)
dx1_desc_2012<- arrange(dx1_groups_2012, desc(count))
dx1_desc_2012$pct <- (dx1_desc_2012$count/sum(dx1_desc_2012$count))*100


valid_dx1_2013<- case_control[(!is.na(case_control$dx1)) & case_control$mrsa== TRUE & case_control$ayear== "2013", ]
dx1_groups_2013<- valid_dx1_2013 %>%
  group_by(dx1) %>%
  summarise(count= n()) %>%
  filter(count>150)
dx1_desc_2013<- arrange(dx1_groups_2013, desc(count))
dx1_desc_2013$pct <- (dx1_desc_2013$count/sum(dx1_desc_2013$count))*100

valid_dx1_2014<- case_control[(!is.na(case_control$dx1)) & case_control$mrsa== TRUE & case_control$ayear== "2014", ]
dx1_groups_2014<- valid_dx1_2014 %>%
  group_by(dx1) %>%
  summarise(count= n()) %>%
  filter(count>150)
dx1_desc_2014<- arrange(dx1_groups_2014, desc(count))
dx1_desc_2014$pct <- (dx1_desc_2014$count/sum(dx1_desc_2014$count))*100

# Stacked bar plot for top primary diagnosis with MRSA

# Rename col name
colnames(dx1_desc_2009)[3] <- "2009"  

colnames(dx1_desc_2010)[3] <- "2010"  

colnames(dx1_desc_2011)[3] <- "2011"  

colnames(dx1_desc_2012)[3] <- "2012"  

colnames(dx1_desc_2013)[3] <- "2013"  

colnames(dx1_desc_2014)[3] <- "2014"  

dx1_desc_2009 <- dx1_desc_2009[,(-2)]
dx1_desc_2010 <- dx1_desc_2010[,(-2)]
dx1_desc_2011 <- dx1_desc_2011[,(-2)]
dx1_desc_2012 <- dx1_desc_2012[,(-2)]
dx1_desc_2013 <- dx1_desc_2013[,(-2)]
dx1_desc_2014 <- dx1_desc_2014[,(-2)]

# Join years into a single data frame
temp <- full_join(dx1_desc_2009,dx1_desc_2010, by = "dx1")

temp <- full_join(temp,dx1_desc_2011, by = "dx1")

temp <- full_join(temp,dx1_desc_2012, by = "dx1")

temp <- full_join(temp,dx1_desc_2013, by = "dx1")

temp <- full_join(temp,dx1_desc_2014, by = "dx1")

data_mrsa_dx1 <- temp

rm(temp)


# Transpose
data_mrsa_dx1 <- t(data_mrsa_dx1)

# Fix column names based on icd code
colnames(data_mrsa_dx1) = data_mrsa_dx1[1, ] # the first row will be the header
data_mrsa_dx1 = data_mrsa_dx1[-1, ]   

# Transpose
data_mrsa_dx1 <- t(data_mrsa_dx1)

# Color Brewer
diverging <- brewer.pal(8,"Spectral")

# Assign 0 to Null values
data_mrsa_dx1[is.na(data_mrsa_dx1)] <- 0

barplot(as.matrix(data_mrsa_dx1),xlim=c(0, ncol(as.matrix(data_mrsa_dx1)) + 5), ylim = range(0,100), col=diverging)
legend("right",cex = 0.80,legend=c("Unspecified septicemia",
                                   "Cellulitis & Abscess of face",
                                   "Conductive hearing loss",
                                   "Cellulitis & Abscess of Upper Arm",
                                   "Cellulitis & Abscess of Buttocks",
                                   "Other post-op infection",
                                   "Cellulitis & Abscess of Trunk",
                                   "Cellulitis & Abscess of Leg"),pt.cex = 2, fill = diverging[8:1])
