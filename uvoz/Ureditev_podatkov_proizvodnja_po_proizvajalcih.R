##Pridobivanje tabel iz spletne strani (Podatki o proizvodnji avtomobilov po proizvajalcih)

library(rvest)
library(gsubfn)
library(readr)
library(dplyr)

link <- "https://en.wikipedia.org/wiki/List_of_manufacturers_by_motor_vehicle_production#2015"
stran <- html_session(link) %>% read_html()

#tabele v letih od 2015 do 2012, od 2008 do 2004 (ta leta so psebej ker je class=wikitable sortable)
data1 <- list()
for (i in 1:9){
  data1[[i]]<- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    .[[i]] %>% html_table(dec = ",")
}



#uredimo tabele in jih zlozimo skupaj

leta <- c(2015:2012,2008:2004)

for (i in 1:9){
  if (i == 1){
    tabela <- data1[[i]]
    tabela <- tabela[c(2,3,4)] #izbrišemo prvi stolpec
    colnames(tabela) <- c("Group","Country","Number") #dodamo imena stolpcev
    tabela$Year <- rep(leta[i], length(tabela[[1]])) #dodamo stolpec z leti
    tabela <- tabela[c(1,4,2,3)] #spremenimo vrstni red
    urejena <- tabela
  }
  else{
    tabela <- data1[[i]]
    tabela <- tabela[c(2,3,4)] #izbrišemo prvi stolpec
    colnames(tabela) <- c("Group","Country","Number") #dodamo imena stolpcev
    tabela$Year <- rep(leta[i], length(tabela[[1]])) #dodamo stolpec z leti
    tabela <- tabela[c(1,4,2,3)] #spremenimo vrstni red
    urejena <- rbind(urejena, tabela)
  }
    
}

#########################################################################################

#tabele v letih od 2011 do 2009(ta leta so psebej ker je class=toccolours nowraplinks)
data2 <- list()

for (i in 1:3){
  data2[[i]] <- stran %>% html_nodes(xpath="//table[@class='toccolours nowraplinks']") %>%
    .[[i]] %>% html_table(dec = ",",fill=TRUE)
}

#uredimo podatke za leto 2011
pro2011 <- data2[[1]]
pro2011 <- pro2011[c(1,length(pro2011)-5)]
pro2011 <- pro2011[-c(1:3,31:33),] # zbrišemo prve 3 in zadnje 3 vrstice
colnames(pro2011) <- c("Group","Number") #imena stolpcev
pro2011$Year <- rep(2011, length(pro2011[[1]])) #dodamo stolpec Year

#uredimo podatke za leto 2010
pro2010 <- data2[[2]]
pro2010 <- pro2010[c(1,length(pro2010)-5)]
pro2010 <- pro2010[-c(1:3,41:44),] # zbrišemo prve 3 in zadnje 4 vrstice
colnames(pro2010) <- c("Group","Number") #imena stolpcev
pro2010$Year <- rep(2010, length(pro2010[[1]])) #dodamo stolpec Year

#uredimo podatke za leto 2009
pro2009 <- data2[[3]]
pro2009 <- pro2009[c(1,length(pro2009)-5)]
pro2009 <- pro2009[-c(1:3,54:56),] # zbrišemo prve 3 in zadnje 3 vrstice
colnames(pro2009) <- c("Group","Number") #imena stolpcev
pro2009$Year <- rep(2009, length(pro2009[[1]])) #dodamo stolpec Year


#tabela s podatki proizvajalcev in državo proizvajanja
link2 <- "https://en.wikipedia.org/wiki/Automotive_industry"
stran2 <- html_session(link2) %>% read_html()
drzave <- stran2 %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[3]] %>% html_table(dec = ",")

drzave <- drzave[c(1,4)]
colnames(drzave) <- c("Group", "Country")








