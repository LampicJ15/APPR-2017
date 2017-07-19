# 4. faza: Analiza podatkov

library(readr)
library(dplyr)
library(ggplot2)
library(rworldmap)
library(maps)

proizvodnja <- read.csv2("podatki/urejeni/proizvodnja.csv")
gdp <- read.csv2("podatki/urejeni/gdp.csv")

#Analiza proizvodnje (vpliv finančne krize na proizvodnjo avtomobilov)

letna.proizvodnja <- proizvodnja %>% group_by(Country,Year) %>% summarise( Annual = sum(Number)) 

##sprememba v proizvodnji v času finančne krize (leto 2007 -> leto 2009)
proizvodnja2007 <- letna.proizvodnja %>%filter(Year == 2007)
proizvodnja2009 <- letna.proizvodnja %>%filter(Year == 2009)
s <- left_join(proizvodnja2009,proizvodnja2007,by="Country")

sprememba <- (s$Annual.x - s$Annual.y)/s$Annual.y * 100 #sprememba v procentih 
sprememba.proizvodnje <- data.frame(proizvodnja2009$Country, sprememba)
colnames(sprememba.proizvodnje)<-c("Country","Production_change")
sprememba.proizvodnje$Country <- as.character(sprememba.proizvodnje$Country)

##spremeba BDP v letih 2007 - 2009

s2 <- inner_join(filter(gdp,Year==2009),filter(gdp,Year==2007),by="Country")
sprememba2 <- ( s2$GDP.x - s2$GDP.y )/s2$GDP.y * 100 #sprememba BDP v procenith v letih 2007 na 2009
sprememba.BDP <- data.frame(filter(gdp,Year==2007)$Country, sprememba2)
colnames(sprememba.BDP) <- c("Country","BDP_change")
sprememba.BDP$Country <- as.character(sprememba.BDP$Country)

##popravek imen v tabeli BDP
indexi <- which( is.na( left_join(sprememba.proizvodnje, sprememba.BDP)$BDP_change)) #indexi kjer se imena drzav iz sprememba.prodaje ne ujemajo s sprememba.BDP
drzave <- sprememba.proizvodnje$Country[indexi]

for (drzava in drzave){
  mesto <- grep(substr(drzava,1,7),sprememba.BDP$Country)
  sprememba.BDP$Country[mesto] <- drzava
}

ostale.drzave <- c("SOUTH KOREA","USA","VIETNAM")
ostale.drzave2 <- c("REPUBLIC OF KOREA","UNITED STATES","VIET NAM")

i = 1
for (drzava in ostale.drzave2){
  sprememba.BDP$Country[ grep(drzava, sprememba.BDP$Country) ] <- ostale.drzave[i]
  i = i + 1
}

sprememba <- left_join(sprememba.proizvodnje,sprememba.BDP)
sprememba <- sprememba[-which(is.na(sprememba$BDP_change)),]

##Razvrščanje držav glede na vpliv finančne krize na proizvodnjo

k <- kmeans(scale(sprememba.proizvodnje$Production_change), 5, nstart = 1000)
skupine <- data.frame(Country=sprememba.proizvodnje$Country, Group = factor(k$cluster))
skupine$Country <- as.character(skupine$Country)

##zemljevid 
world <- map_data("world")
world<-world[c(1:5)]
colnames(world) <-c("long","lat","group","order","Country")
world$Country <- toupper(world$Country)

skupine <- left_join(world,skupine, by="Country")
map2 <- ggplot() + geom_polygon(data = skupine,aes(x=long, y = lat, group = group,fill=Group))

####korelacija med spremembo gospodarkse rasti ter proizvodnjo avtomobilov v letih od 2007-2009
cor.PB <- cor(sprememba$Production_change,sprememba$BDP_change)
