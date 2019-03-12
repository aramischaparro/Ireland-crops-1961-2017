
library(ggplot2)
library(plotly)
library(plyr)
library(flexdashboard)
library(dplyr)
library(tidyr)
library(datasets)
library (corrplot)
#Set directory
getwd()
setwd("C:\\Users\\pauli\\Documents\\R\\projects\\Ireland-crops-1961-2017")
data<-read.csv('Production_Crops_E_Europe_NOFLAG.csv')

#REMOVE SPREAD COLUMNS "ELEMENT"
a<-new.env()
years<-c("Y1961","Y1962","Y1963","Y1964","Y1965","Y1966","Y1967","Y1968","Y1969","Y1970","Y1971","Y1972","Y1973","Y1974","Y1975","Y1976","Y1977","Y1978","Y1979","Y1980","Y1981","Y1982","Y1983","Y1984","Y1985","Y1986","Y1987","Y1988","Y1989","Y1990","Y1991","Y1992","Y1993","Y1994","Y1995","Y1996","Y1997","Y1998","Y1999","Y2000","Y2001","Y2002","Y2003","Y2004","Y2005","Y2006","Y2007","Y2008","Y2009","Y2010","Y2011","Y2012","Y2013","Y2014","Y2015","Y2016","Y2017")

for (year in years){
  temp<-data[,c("Area","Item","Element",year)];
  a[[year]]<-spread(temp,Element,year);
}#SPREAD() function is in tidyr

newdata<-a[["Y1961"]][,c("Area","Item")]

for (year in years){
  newdata<-cbind(newdata,a[[year]][,c("Area harvested","Production","Yield")])
}
names<-colnames(newdata)
newnames<-names<-c(names[1],names[2])

for (year in years){
  newnames<-append(newnames,c(paste("area",year),paste("production",year),paste("yield",year)));
}
colnames(newdata)<-newnames
View(newdata)



#get rid of scientific notation
options(scipen = 999)


#view all data
View(newdata)


#view data Ireland
na_ireland<- newdata[newdata$Area=="Ireland",]
View(na_ireland)


#data NA removed              --> ireland variable does not contain NA, therefore some rows have been deleted
ireland <- na.omit(na_ireland)

View(ireland)
View(IRELAND)


#data NA turn into cero "0"   --> IRELAND variable contains cero, therefore all rows have been preserved
IRELAND = as.data.frame(na_ireland)
IRELAND[is.na(na_ireland)] = 0


View(IRELAND[1,])
View(IRELAND[,1]
             
     
IRELAND_AREA =IRELAND[seq(3,171,by=3)]
IRELAND_PRODUCTION=IRELAND[seq(4,172,by=3)]
IRELAND_YIELD=IRELAND[seq(5,173,by=3)]

View(IRELAND_AREA)
View(IRELAND_PRODUCTION)
View(IRELAND_YIELD)

#delete column area (country)
ireland[,1] = NULL
IRELAND[,1] = NULL


#transpose
transpose=t(IRELAND)
View(transpose)



#   #delete rows "area" and "yield"
# transpose=transpose[-c(1),]
# 
# for (i in transpose[seq(1:)]{
#   prod=i[-c(TRUE,FALSE,FALSE),]
# }
# View(prod)



#SAVE/EXPORT DATA to a csv file
write.table(ireland, file="irelandNOna.csv", row.names=F, sep=",")
write.table(IRELAND, file="IRELANDceros.csv", row.names=F, sep=",")






