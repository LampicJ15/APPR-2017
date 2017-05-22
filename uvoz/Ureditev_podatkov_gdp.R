#Uvoz podatkov o BDPju držav (podani v US dollarjih) (https://unstats.un.org/unsd/snaama/dnlList.asp)

#paket read.xl
library(readxl)
library(readr)
library(dplyr)
library(reshape2)

gdp <- read_excel("podatki/neurejeni/gdp.xls",skip = 10,col_names = FALSE) #shranimo podatke tabele 

colnames(gdp) <- c("Country","Indikator",1970:2015)

#vzamemo samo vrstice, ki imajo podatke o BDPju (angl. GDP)
mesta <- grep("Gross Domestic Product", gdp$Indikator)

gdp <- gdp[mesta,]

#2. stolpca ne rabimo več
gdp[2] <- NULL

#spremenimo tabelo v tidy data
gdp <- melt(gdp, id.vars = "Country", 
                   measure.vars = names(gdp)[-1], 
                   variable.name = "Year", 
                   value.name = "GDP", 
                   na.rm = TRUE)

#spremenimo class za Year
gdp$Year <- parse_integer(gdp$Year)

#vse upper case črke pri imenih držav
gdp$Country <- toupper(gdp$Country)

#rabimo podatke samo od leta 2004 naprej
gdp <- gdp %>% filter(Year >= 2004)

#zapišimo datoteko
write.csv2(gdp, "podatki/urejeni/gdp.csv",row.names = FALSE)


