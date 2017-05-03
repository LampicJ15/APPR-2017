##ureditev podatkov o proizvodnji tovornjakov (HT - heavy trucks)

setwd("C:/Users/Uporabnik/Dropbox/Faks/R Studio/APPR-2017/podatki/neurejeni/production-ht")

#paket read.xl
library(readxl)
library(readr)

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

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Treba je še urediti imena držav in izbrisati nedržave !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#zapišimo urejeno datoteko
write.csv2(datoteka, "proizvodnjaHT.csv",row.names = FALSE)
