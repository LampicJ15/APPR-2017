#Ureditev podatkov o številu prebivalstva po državah

library(readr)

populacija <- read_csv("podatki/neurejeni/population.csv", col_names = FALSE,skip = 1,locale = locale(encoding = "UTF-8"))

#zbrišemo 2 . stolpec
populacija[2]<-NULL

#spremenimo imena stolpcev 
colnames(populacija) <- c("Country", 2002:2016)

#odstranimo vrstice z NA v stolpcu Country

populacija <- populacija[!is.na(populacija$Country),]

#zbrisimo se zadnji 2 vrstici
populacija <- populacija[-c(218,219),]

#pretvorimo tabelo v Tidy data
library(reshape2)

populacija <- melt(populacija, id.vars = "Country", 
                  measure.vars = names(populacija)[-1], 
                  variable.name = "Year", 
                  value.name = "Number", 
                  na.rm = TRUE)

#vrednosti v stolpcu Year spremenimo v integer
populacija$Year <- parse_integer(populacija$Year)


#urediti vrednosti v stolpcu Year, ker so nekje številke
#podane v obliki 5542515241.15565566
mesta <- grep("[0-9]+\\..+",populacija$Number)
populacija$Number[mesta] <- gsub("([0-9]+)(\\..+)","\\1",populacija$Number[mesta])

#zbršiemo tiste vrstice, ki niso številke (so oblike ..)
populacija <- populacija[-grep("^\\.",populacija$Number),]

#vrednosti v stolpcu Number spremenimo v integer
populacija$Number <- parse_integer(populacija$Number)

#imena držav napišemo z veliko
populacija$Country <- toupper(populacija$Country)

#zapišimo datoteko
write.csv2(populacija, "podatki/urejeni/populacija.csv",row.names = FALSE)

