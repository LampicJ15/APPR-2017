#VIZUALIZACIJA PODATKOV

library(readr)
library(dplyr)
library(ggplot2)

prodaja <- read.csv2("podatki/urejeni/prodaja.csv")

#prodaja po letih 

prodaja %>% group_by(Year) %>% summarise( Annual = sum(Number)) -> letna.prodaja

graf1 <- ggplot(data = letna.prodaja) + aes(x=letna.prodaja$Year, y=letna.prodaja$Annual) + geom_bar(stat="identity",fill ="cornflowerblue") + geom_line(color="red",size=1.2)
graf1<- graf1 + xlab("Leto") + ylab("Število prodanih avtomobilov") +ggtitle("Letna prodaja avtomobilov")
print(graf1)

#uporaba po letih (ni loceno glede na tip vozila) (?? graf je treba popraviti x-os)
uporaba <- read.csv2("podatki/urejeni/uporaba.csv")

letna.uporaba  <- uporaba %>% group_by(Year) %>% summarise( Annual = sum(Number))

graf2 <- ggplot(data = letna.uporaba) + aes(x=letna.uporaba$Year, y=letna.uporaba$Annual) + geom_bar(stat="identity",fill ="cornflowerblue") + scale_x_discrete() 
graf2 <- graf2 + xlab("Leto") + ylab("Število prodanih avtomobilov") +ggtitle("Letna uporaba avtomobilov")
print(graf2)

#uporaba po letih loceno glede na tip vozila
letna.uporaba2  <- uporaba %>% group_by(Year, Type) %>% summarise( Annual = sum(Number))
PC <- letna.uporaba2 %>% filter(Type == "PC")
CV <- letna.uporaba2 %>% filter(Type == "CV")

graf3<- ggplot(data = NULL, aes(x = PC$Year)) + geom_bar(stat="identity", aes(x=PC$Year,y=PC$Annual),fill="cornflowerblue") + geom_bar(stat="identity", aes(x=PC$Year,y=CV$Annual),fill="red")
graf3 <- graf3 + xlab("Leto") + ylab("Število prodanih avtomobilov") + ggtitle("Letna uporaba avtomobilov glede na tip") 
print(graf3)

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



