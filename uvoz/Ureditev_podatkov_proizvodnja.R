##ureditev podatkov o proizvodnji 

#paket read.xl
library(readxl)
library(readr)

#naredimo funkcijo za urejanje podatkov o proizvodnji BC

#naredimo funkcijo za urejanje podatkov o proizvodnji

uredi.pro <- function(neurejena, leto, tip){ #vhodni podatki: neurejena npr. production-bc/production-bc-2013.xls
  pot = paste("podatki/neurejeni",neurejena, sep="/")
  nova_datoteka <-read_excel(pot, skip = 13, col_names = FALSE, na = "NA")
  
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


#vse datoteke uredi in jih zdruzi

productionBC <- list.files("podatki/neurejeni/production-bc",pattern = ".*\\.xls") #datoteke iz danega direktorija

leto <- 2005

for (i in c(1:length(productionBC)) ){
  if (i > 1){
    pot <- paste("production-bc",productionBC[i],sep="/") #združi string
    urejena <- uredi.pro(pot, leto,"BC")
    datoteka <- rbind(datoteka, urejena)
    leto <- leto + 1
  }
  else{
    pot <- paste("production-bc",productionBC[i],sep="/")
    datoteka <- uredi.pro(pot, leto,"BC")
    leto <- leto + 1
  }
}

prodBC <- datoteka




##ureditev podatkov o proizvodnji komercialnih vozil (CV - commercial vehicles)

#vse datoteke uredi in jih zdruzi
productionCV <- list.files("podatki/neurejeni/production-cv",pattern = ".*\\.xls") #pobere samo file s končnico xls(x)

leto <- 2005

for (i in c(1:length(productionCV)) ){
  if (i > 1){
    pot <- paste("production-cv",productionCV[i],sep="/")
    urejena <- uredi.pro(pot, leto,"CV")
    datoteka <- rbind(datoteka, urejena)
    leto <- leto + 1
  }
  else{
    pot <- paste("production-cv",productionCV[i],sep="/")
    datoteka <- uredi.pro(pot, leto,"CV")
    leto <- leto + 1
  }
}

prodCV <- datoteka

##ureditev podatkov o proizvodnji tovornjakov (HT - heavy trucks)

#Določitev direktorija kjer so podatki o proizvodnji tovornjakov

#vse datoteke uredi in jih zdruzi
productionHT <- list.files("podatki/neurejeni/production-ht",pattern = ".*\\.xls") #pobere samo file s končnico xls(x)

leto <- 2005

for (i in c(1:length(productionHT)) ){
  if (i > 1){
    pot <- paste("production-ht",productionHT[i],sep="/")
    urejena <- uredi.pro(pot, leto,"HT")
    datoteka <- rbind(datoteka, urejena)
    leto <- leto + 1
  }
  else{
    pot <- paste("production-ht",productionHT[i],sep="/")
    datoteka <- uredi.pro(pot, leto,"HT")
    leto <- leto + 1
  }
}

prodHT <- datoteka


##ureditev podatkov o proizvodnji osebnih avtomobilov (PC - passanger car)


#vse datoteke uredi in jih zdruzi
productionPC<- list.files("podatki/neurejeni/production-pc",pattern = ".*\\.xls") #pobere samo file s končnico xls(x)

leto <- 2005

for (i in c(1:length(productionPC)) ){
  if (i > 1){
    pot <- paste("production-pc",productionPC[i],sep="/")
    urejena <- uredi.pro(pot, leto,"PC")
    datoteka <- rbind(datoteka, urejena)
    leto <- leto + 1
  }
  else{
    pot <- paste("production-pc",productionPC[i],sep="/")
    datoteka <- uredi.pro(pot, leto,"PC")
    leto <- leto + 1
  }
}

prodPC <- datoteka

#zdruzimo vse urejene tabele
proizvodnja <- rbind(prodPC,prodHT,prodCV,prodBC)

#uredimo tabelo proizvodnja




#zapišimo dobljeno datoteko
#write.csv2(proizvodnja,"podatki/urejeni/proizvodnja.csv",row.names = FALSE)
