#VIZUALIZACIJA PODATKOV

library(readr)
library(dplyr)
library(ggplot2)
library(rworldmap)
library(maps)

prodaja <- read.csv2("podatki/urejeni/prodaja.csv")

#prodaja po letih (ni ločeno glede na tip vozila)

letna.prodaja <- prodaja %>% group_by(Year) %>% summarise( Annual = sum(Number)) 

graf.prodaja <- ggplot(data = letna.prodaja) + aes(x=Year, y=Annual/1e6) + geom_bar(stat="identity",fill ="cornflowerblue") + geom_line(color="red",size=1.2)
graf.prodaja<- graf.prodaja + xlab("Leto") + ylab("Število prodanih avtomobilov") +ggtitle("Letna prodaja avtomobilov (v milijonih)")

#prodaja po letih (ločeno glede na tip vozila)
letna.prodaja2 <- prodaja %>% group_by(Year, Type) %>% summarise(Annual = sum(Number))
graf.prodaja2 <- ggplot(data = letna.prodaja2, aes(x = factor(Year), y = Annual/1e6, fill = Type)) + geom_bar(stat="identity", position="dodge")
graf.prodaja2 <- graf.prodaja2 + xlab("Leto") + ylab("Število prodanih avtomobilov") + ggtitle("Letna prodaja avtomobilov glede na tip (v milijonih)")


#uporaba po letih (ni loceno glede na tip vozila)
uporaba <- read.csv2("podatki/urejeni/uporaba.csv")

letna.uporaba  <- uporaba %>% group_by(Year) %>% summarise( Annual = sum(Number))

graf.uporaba <- ggplot(data = letna.uporaba, aes(x=factor(Year), y=Annual/1e6)) + geom_bar(stat="identity",fill ="cornflowerblue")
graf.uporaba <- graf.uporaba + xlab("Leto") + ylab("Število avtomobilov v uporabi (v milijonih)") +ggtitle("Letna uporaba avtomobilov")


#uporaba po letih loceno glede na tip vozila
letna.uporaba2  <- uporaba %>% group_by(Year, Type) %>% summarise( Annual = sum(Number))

graf.uporaba2<- ggplot(data = letna.uporaba2, aes(x = factor(Year), y = Annual/1e6, fill = Type)) + geom_bar(stat="identity", position="dodge")
graf.uporaba2 <- graf.uporaba2 + xlab("Leto") + ylab("Število prodanih avtomobilov") + ggtitle("Letna uporaba avtomobilov glede na tip (v milijonih)") 


#proizvodnja po letih (ni ločeno glede na tip vozila)
proizvodnja <- read.csv2("podatki/urejeni/proizvodnja.csv")

#proizvodnja po letih (ni ločeno glede na tip vozila)
letna.proizvodnja <- proizvodnja %>% group_by(Year) %>% summarise(Annual = sum(Number, na.rm = TRUE)) #na.rm = TRUE mankajoče vrednosti odstranjene
graf.proizvodnja <- ggplot(data = letna.proizvodnja, aes(x= factor(Year),y=Annual/1e6)) + geom_bar(stat="identity",fill="cornflowerblue")
graf.proizvodnja <- graf.proizvodnja + xlab("Leto") +ylab("Število proizvedenih avtomobilov") + ggtitle("Letna proizvodnja avtomobilov (v milijonih)")


#proizvodnja po letih (ločeno glede na tip vozila)

letna.proizvodnja2 <- proizvodnja %>% group_by(Year,Type) %>% summarise(Annual = sum(Number, na.rm = TRUE))
graf.proizvodnja2 <- ggplot(data = letna.proizvodnja2, aes(x= factor(Year),y=Annual/1e6,fill=Type)) + geom_bar(stat="identity", position = "dodge")
graf.proizvodnja2 <- graf.proizvodnja2 + xlab("Leto") +ylab("Število proizvedenih avtomobilov") + ggtitle("Letna proizvodnja avtomobilov (v milijonih)")



#prikaz podatkov na zemljevidu za proizvodnjo v letu 2015
pro2015 <- proizvodnja %>% filter(Year == 2015) %>%group_by(Country) %>% summarise(Production = sum(Number))

#zemljevid sveta
world <- map_data("world")
world<-world[c(1:5)]
colnames(world) <-c("long","lat","group","order","Country")
world$Country <- toupper(world$Country)

#zemljevid proizvodnje avtomobilov po državah v miljonih
pro2015 <- left_join(world,pro2015, by="Country")
svet.product <- ggplot() + geom_polygon(data = pro2015,
                                    aes(x=long, y = lat, group = group,fill=Production/1e6)) +
  guides(fill = guide_colorbar(title = "Production (millions)"))+coord_fixed(1.3)




