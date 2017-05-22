#VIZUALIZACIJA PODATKOV

library(readr)
library(dplyr)
library(ggplot2)

prodaja <- read.csv2("podatki/urejeni/prodaja.csv")

#prodaja po letih (ni ločeno glede na tip vozila)

letna.prodaja <- prodaja %>% group_by(Year) %>% summarise( Annual = sum(Number)) 

graf.prodaja <- ggplot(data = letna.prodaja) + aes(x=Year, y=Annual) + geom_bar(stat="identity",fill ="cornflowerblue") + geom_line(color="red",size=1.2)
graf.prodaja<- graf.prodaja + xlab("Leto") + ylab("Število prodanih avtomobilov") +ggtitle("Letna prodaja avtomobilov")
print(graf.prodaja)

#prodaja po letih (ločeno glede na tip vozila)
letna.prodaja2 <- prodaja %>% group_by(Year, Type) %>% summarise(Annual = sum(Number))
graf.prodaja2 <- ggplot(data = letna.prodaja2, aes(x = factor(Year), y = Annual, fill = Type)) + geom_bar(stat="identity", position="dodge")
graf.prodaja2 <- graf.prodaja2 + xlab("Leto") + ylab("Število prodanih avtomobilov") + ggtitle("Letna prodaja avtomobilov (ločeno)")
print(graf.prodaja2)

#uporaba po letih (ni loceno glede na tip vozila)
uporaba <- read.csv2("podatki/urejeni/uporaba.csv")

letna.uporaba  <- uporaba %>% group_by(Year) %>% summarise( Annual = sum(Number))

graf.uporaba <- ggplot(data = letna.uporaba, aes(x=factor(Year), y=Annual)) + geom_bar(stat="identity",fill ="cornflowerblue")
graf.uporaba <- graf.uporaba + xlab("Leto") + ylab("Število avtomobilov v uporabi") +ggtitle("Letna uporaba avtomobilov")
print(graf.uporaba)

#uporaba po letih loceno glede na tip vozila
letna.uporaba2  <- uporaba %>% group_by(Year, Type) %>% summarise( Annual = sum(Number))

graf.uporaba2<- ggplot(data = letna.uporaba2, aes(x = factor(Year), y = Annual, fill = Type)) + geom_bar(stat="identity", position="dodge")
graf.uporaba2 <- graf.uporaba2 + xlab("Leto") + ylab("Število prodanih avtomobilov") + ggtitle("Letna uporaba avtomobilov glede na tip") 
print(graf.uporaba2)

#proizvodnja po letih (ni ločeno glede na tip vozila)
proizvodnja <- read.csv2("podatki/urejeni/proizvodnja.csv")

#proizvodnja po letih (ni ločeno glede na tip vozila)
letna.proizvodnja <- proizvodnja %>% group_by(Year) %>% summarise(Annual = sum(Number, na.rm = TRUE)) #na.rm = TRUE mankajoče vrednosti odstranjene
graf.proizvodnja <- ggplot(data = letna.proizvodnja, aes(x= factor(Year),y=Annual)) + geom_bar(stat="identity",fill="cornflowerblue")
graf.proizvodnja <- graf.proizvodnja + xlab("Leto") +ylab("Število proizvedenih avtomobilov") + ggtitle("Letna proizvodnja avtomobilov")
print(graf.proizvodnja)

#proizvodnja po letih (ločeno glede na tip vozila)

letna.proizvodnja2 <- proizvodnja %>% group_by(Year,Type) %>% summarise(Annual = sum(Number, na.rm = TRUE))
graf.proizvodnja2 <- ggplot(data = letna.proizvodnja2, aes(x= factor(Year),y=Annual,fill=Type)) + geom_bar(stat="identity", position = "dodge")
graf.proizvodnja2 <- graf.proizvodnja2 + xlab("Leto") +ylab("Število proizvedenih avtomobilov") + ggtitle("Letna proizvodnja avtomobilov")
print(graf.proizvodnja2)


#prikaz podatkov na zemljevidu za proizvodnjo v letu 2015

pro2015 <- proizvodnja %>% filter(Year == 2015) %>%group_by(Country) %>% summarise(Production = sum(Number))


#tabela geografske širine in višine posamezne države
koordinati <- read.csv("podatki/neurejeni/koordinati.csv")
koordinati <- koordinati[c(1,5,6)]
colnames(koordinati) <- c("Country","Latitude","Longitude")
koordinati$Country <- toupper(koordinati$Country)
koordinati$Country <- parse_character(koordinati$Country)

#dodamo podatke o koordinatah 
pro2015 <- left_join(pro2015, koordinati, by="Country")

#zemljevid sveta
library(maps)
map()
symbols(pro2016$Longitude, pro2016$Latitude, bg="blue",,lwd = 1, circles = pro2016$Production, inches=0.25, add = TRUE)



