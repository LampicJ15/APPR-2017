##ureditev podatkov o proizvodnji 

#paket read.xl
library(readxl)
library(readr)

#naredimo funkcijo za urejanje podatkov o proizvodnji BC

#naredimo funkcijo za urejanje podatkov o proizvodnji

uredi.pro <- function(neurejena, leto, tip){
  nova_datoteka <-read_excel(neurejena, skip = 13, col_names = FALSE, na = "NA")
  
  #Izbrišemo 2. in 4. stolpec
  nova_datoteka[c(2,4)] <- NULL
  
  #spremenimo imena stolpcev
  colnames(nova_datoteka) <- c("Country", leto)
  #odstranimo vrstice z NA v stoplcu Countries
  nova_datoteka <-nova_datoteka[!is.na(nova_datoteka$Country),]
  
  #pretvorimo tabelo v Tidy data
  library(reshape2)
  
  nova_datoteka <- melt(nova_datoteka, id.vars = "Country", 
                        measure.vars = names(nova_datoteka)[-1], 
                        variable.name = "Year", 
                        value.name = "Number", 
                        na.rm = TRUE)
  
  #dodamo stolpec Type - tip vozila
  nova_datoteka$Type <- rep(tip,length(nova_datoteka[[1]])) 
  
  #spremenimo tip v stolpcu Year v numeric
  nova_datoteka$Year <- parse_integer(nova_datoteka$Year)
  
  #preuredimo vrstni red stolpcev
  nova_datoteka <- nova_datoteka[c(1,4,2,3)] # Vrstni red: Country, Type, Year,Number
  
}

##Uredimo podatke o proizvodnji avtobusov (BC - busses and coaches)

#določimo direktorij, kjer se nahajajo podatki o proizvodnji avtobusov

setwd("C:/Users/Uporabnik/Dropbox/Faks/R Studio/APPR-2017/podatki/neurejeni/production-bc")
#vse datoteke uredi in jih zdruzi

productionBC <- list.files(getwd())

leto <- 2005

for (i in c(1:length(productionBC)) ){
  if (i > 1){
    urejena <- uredi.pro(productionBC[i], leto,"BC")
    datoteka <- rbind(datoteka, urejena)
    leto <- leto + 1
  }
  else{
    datoteka <- uredi.pro(productionBC[i], leto,"BC")
    leto <- leto + 1
  }
}

prodBC <- datoteka
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Treba je še urediti imena držav in izbrisati nedržave !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#zapišimo urejeno datoteko
write.csv2(datoteka, "proizvodnjaBC.csv",row.names = FALSE)

##ureditev podatkov o proizvodnji komercialnih vozil (CV - commercial vehicles)

#Določimo direktorij kjer se nahajajo podatki o proizvodnji komercialnih vozil
setwd("C:/Users/Uporabnik/Dropbox/Faks/R Studio/APPR-2017/podatki/neurejeni/production-cv")

#vse datoteke uredi in jih zdruzi
productionCV <- list.files(getwd())

leto <- 2005

for (i in c(1:length(productionCV)) ){
  if (i > 1){
    urejena <- uredi.pro(productionCV[i], leto,"CV")
    datoteka <- rbind(datoteka, urejena)
    leto <- leto + 1
  }
  else{
    datoteka <- uredi.pro(productionCV[i], leto,"CV")
    leto <- leto + 1
  }
}

prodCV <-datoteka
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Treba je še urediti imena držav in izbrisati nedržave !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##ureditev podatkov o proizvodnji tovornjakov (HT - heavy trucks)

#Določitev direktorija kjer so podatki o proizvodnji tovornjakov
setwd("C:/Users/Uporabnik/Dropbox/Faks/R Studio/APPR-2017/podatki/neurejeni/production-ht")

#vse datoteke uredi in jih zdruzi
productionHT <- list.files(getwd())

leto <- 2005

for (i in c(1:length(productionHT)) ){
  if (i > 1){
    urejena <- uredi.pro(productionHT[i], leto,"HT")
    datoteka <- rbind(datoteka, urejena)
    leto <- leto + 1
  }
  else{
    datoteka <- uredi.pro(productionHT[i], leto,"HT")
    leto <- leto + 1
  }
}

prodHT <- datoteka


##ureditev podatkov o proizvodnji osebnih avtomobilov (PC - passanger car)

#Določitev direktorija kjer se nahajajo podatki o proizvodnji osebnih avtomobilov
setwd("C:/Users/Uporabnik/Dropbox/Faks/R Studio/APPR-2017/podatki/neurejeni/production-pc")

#vse datoteke uredi in jih zdruzi
productionPC <- list.files(getwd())

leto <- 2005

for (i in c(1:length(productionPC)) ){
  if (i > 1){
    urejena <- uredi.pro(productionPC[i], leto,"PC")
    datoteka <- rbind(datoteka, urejena)
    leto <- leto + 1
  }
  else{
    datoteka <- uredi.pro(productionPC[i], leto,"PC")
    leto <- leto + 1
  }
}

prodPC <- datoteka

#zdruzimo vse urejene tabele
proizvodnja <- rbind(prodPC,prodHT,prodCV,prodBC)

#zapišimo dobljeno datoteko

setwd("C:/Users/Uporabnik/Dropbox/Faks/R Studio/APPR-2017/podatki/urejeni")

write.csv2(proizvodnja,"proizvodnja.csv",row.names = FALSE)
