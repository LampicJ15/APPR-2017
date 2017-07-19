##Ureditev podatkov o prodaji osebnih avtomobilov leto 2005-2016 (ProdajaOA - prodaja osebnih avtomobilov)

#paket read.xl
library(readxl)
library(readr)

prodajaOA <- read_excel("podatki/neurejeni/pc-sales.xlsx",skip = 10,col_names = FALSE, na = "NA") #shranimo podatke tabele 

#zbrisemo 2., 3. in 4. stolpec
prodajaOA[2:4] <- NULL

#spremenimo imena stolpcev 
stolpci <- c("Country", 2005:2016)
colnames(prodajaOA) <- stolpci

#odstranimo vrstice z NA v stolpcu Countries
prodajaOA <- prodajaOA[!is.na(prodajaOA$Country),]

#pretvorimo tabelo v Tidy data
library(reshape2)

prodajaOA <- melt(prodajaOA, id.vars = "Country", 
                  measure.vars = names(prodajaOA)[-1], 
                  variable.name = "Year", 
                  value.name = "Number", 
                  na.rm = TRUE)
          
#dodamo stolpec Type - tip vozila
prodajaOA$Type <- rep("PC",length(prodajaOA[[1]])) #PC - passeneger car

#preuredimo vrstni red stolpcev
prodajaOA <- prodajaOA[c(1,4,2,3)] #Country, Type, Year,Number

#vrednosti v stolpcu Year spremenimo v numeric
prodajaOA$Year <- parse_integer(prodajaOA$Year)

##Ureditev podatkov o prodaji komercialnih avtomobilov leto 2005-2016 (ProdajaKA - prodaja komercialnih avtomobilov)
prodajaKA <- read_excel("podatki/neurejeni/cv-sales.xlsx",skip = 10,col_names = FALSE, na = "NA") #shranimo podatke tabele 

#zbrisemo 2., 3. in 4. stolpec
prodajaKA[2:4] <- NULL

#spremenimo imena stolpcev 
colnames(prodajaKA) <- stolpci

#odstranimo vrstice z NA v stolpcu Countries
prodajaKA <- prodajaKA[!is.na(prodajaKA$Country),]

#pretvorimo tabelo v Tidy data

prodajaKA <- melt(prodajaKA, id.vars = "Country", 
                  measure.vars = names(prodajaKA)[-1], 
                  variable.name = "Year", 
                  value.name = "Number", 
                  na.rm = TRUE)

#dodamo stolpec Type - tip vozila
prodajaKA$Type <- rep("CV",length(prodajaKA[[1]])) #CV - commerciale vehicle

#preuredimo vrstni red stolpcev
prodajaKA <- prodajaKA[c(1,4,2,3)] #Country, Type, Year,Number

#vrednosti v stolpcu Year spremenimo v numeric
prodajaKA$Year <- parse_integer(prodajaKA$Year)

#združimo tabeli
prodaja <- rbind(prodajaKA, prodajaOA)
prodaja$Country[grep("TUKMENISTAN",prodaja$Country)] <-"TURKMENISTAN"
#zapišimo datoteko
write.csv2(prodaja, "podatki/urejeni/prodaja.csv",row.names = FALSE)

