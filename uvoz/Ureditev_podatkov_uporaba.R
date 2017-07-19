##Ureditev podatkov o uporabni osebnih avtomobilov (uporabaOA)

#paket read.xl
library(readxl)
library(readr)

uporabaOA<- read_excel("podatki/neurejeni/pc-inuse.xlsx",skip = 10,col_names = FALSE, na = "NA") #shranimo podatke tabele 

#zbrisemo 2., 3. in 4. stolpec
uporabaOA[2:4] <- NULL

#spremenimo imena stolpcev 
stolpci <- c("Country", 2005:2014)
colnames(uporabaOA) <- stolpci

#odstranimo vrstice z NA v stolpcu Country
uporabaOA<- uporabaOA[!is.na(uporabaOA$Country),]

#pretvorimo tabelo v Tidy data
library(reshape2)

uporabaOA <- melt(uporabaOA, id.vars = "Country", 
                  measure.vars = names(uporabaOA)[-1], 
                  variable.name = "Year", 
                  value.name = "Number", 
                  na.rm = TRUE)

#dodamo stolpec Type - tip vozila
uporabaOA$Type <- rep("PC",length(uporabaOA[[1]])) #PC - passeneger car

#preuredimo vrstni red stolpcev
uporabaOA <- uporabaOA[c(1,4,2,3)] #Country, Type, Year,Number

#vrednosti v stolpcu Year spremenimo v integer
uporabaOA$Year <- parse_integer(uporabaOA$Year)

#vrednosti v stolpcu number pomnožimo s 1000
uporabaOA$Number <- 1000*uporabaOA$Number

##Ureditev podatkov o uporabi komercianlih avtomobilov (uporabaKA)

uporabaKA<- read_excel("podatki/neurejeni/cv-inuse.xlsx",skip = 10,col_names = FALSE, na = "NA") #shranimo podatke tabele 

#zbrisemo 2., 3. in 4. stolpec
uporabaKA[2:4] <- NULL

#spremenimo imena stolpcev 
stolpci <- c("Country", 2005:2014)
colnames(uporabaKA) <- stolpci

#odstranimo vrstice z NA v stolpcu Countries
uporabaKA<- uporabaKA[!is.na(uporabaKA$Country),]

#pretvorimo tabelo v Tidy data
uporabaKA <- melt(uporabaKA, id.vars = "Country", 
                  measure.vars = names(uporabaKA)[-1], 
                  variable.name = "Year", 
                  value.name = "Number", 
                  na.rm = TRUE)

#dodamo stolpec Type - tip vozila
uporabaKA$Type <- rep("CV",length(uporabaKA[[1]])) #CV -commercial vehicle

#preuredimo vrstni red stolpcev
uporabaKA <- uporabaKA[c(1,4,2,3)] #Country, Type, Year,Number

#vrednosti v stolpcu Year spremenimo v integer
uporabaKA$Year <- parse_integer(uporabaKA$Year)

#vrednosti v stolpcu Number pomnožimo s 1000 
uporabaKA$Number <- 1000*uporabaKA$Number


#združimo tabeli
uporaba <- rbind(uporabaKA, uporabaOA)

#zbrišemo vrstice v katerih ni imena držav
uporaba <- uporaba[-grep("ASIA",uporaba$Country),]
uporaba <- uporaba[-grep("CENTRAL",uporaba$Country),]
uporaba <- uporaba[-grep("EUROPE",uporaba$Country),]
uporaba <- uporaba[-grep("NAFTA",uporaba$Country),]
uporaba <- uporaba[-grep("ALL",uporaba$Country),]
#zapišimo datoteko
write.csv2(uporaba, "podatki/urejeni/uporaba.csv",row.names = FALSE)
