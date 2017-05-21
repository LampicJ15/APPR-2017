#VIZUALIZACIJA PODATKOV

library(readr)
library(dplyr)
library(ggplot2)

prodaja <- read.csv2("podatki/urejeni/prodaja.csv")

#prodaja po letih 

prodaja %>% group_by(Year) %>% summarise( Annual = sum(Number)) -> letna.prodaja

graf1 <- ggplot(data = letna.prodaja) + aes(x=letna.prodaja$Year, y=letna.prodaja$Annual,fill=Year) + geom_bar(stat="identity")
print(graf1)
graf1 + xlab("Leto") + ylab("Število prodanih avtomobilov") +ggtitle("Letna prodaja avtomobilov")


#uporaba po letih (ni loceno glede na tip vozila) (?? graf je treba popraviti x-os)
uporaba <- read.csv2("podatki/urejeni/uporaba.csv")

letna.uporaba  <- uporaba %>% group_by(Year) %>% summarise( Annual = sum(Number))

graf2 <- ggplot(data = letna.uporaba) + aes(x=letna.uporaba$Year, y=letna.uporaba$Annual, fill=Year) + geom_bar(stat="identity") + scale_x_discrete() 
graf2 + xlab("Leto") + ylab("Število prodanih avtomobilov") +ggtitle("Letna uporaba avtomobilov")

#uporaba po letih loceno glede na tip vozila
letna.uporaba2  <- uporaba %>% group_by(Year, Type) %>% summarise( Annual = sum(Number))


#proizvodnja po letih
proizvodnja <- read.csv2("podatki/urejeni/proizvodnja.csv")
#prikaz podatkov na zemljevidu za proizvodnjo v letu 2015

pro2016 <- proizvodnja %>% filter(Year == 2015) %>%group_by(Country) %>% summarise(Production = sum(Number))


#tabela geografske širine in višine posamezne države
koordinati <- read.csv("podatki/neurejeni/koordinati.csv")
koordinati <- koordinati[c(1,5,6)]
colnames(koordinati) <- c("Country","Latitude","Longitude")
koordinati$Country <- toupper(koordinati$Country)
koordinati$Country <- parse_character(koordinati$Country)

#dodamo podatke o koordinatah 
pro2016 <- left_join(pro2016, koordinati, by="Country")

#zemljevid sveta
library(maps)
map()
symbols(pro2016$Longitude, pro2016$Latitude, bg="blue",,lwd = 1, circles = pro2016$Production, inches=0.25, add = TRUE)



