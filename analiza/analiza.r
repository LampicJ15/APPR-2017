# 4. faza: Analiza podatkov

library(readr)
library(dplyr)
library(ggplot2)
library(rworldmap)
library(maps)

prodaja <- read.csv2("podatki/urejeni/prodaja.csv")
proizvodnja <- read.csv2("podatki/urejeni/proizvodnja.csv")
uporaba <- read.csv2("podatki/urejeni/uporaba.csv")
proizvajalci <- read.csv2("podatki/urejeni/proizvajalci.csv")
populacija <- read.csv2("podatki/urejeni/populacija.csv")
gdp <- read.csv2("podatki/urejeni/gdp.csv")

########################################################################################################################################################

#Analiza prodaje
letna.prodaja <- prodaja %>% group_by(Country,Year) %>% summarise( Annual = sum(Number)) 

##sprememba v prodaji v času finančne krize (leto 2007 -> leto 2009)
prodaja2007 <- letna.prodaja %>%filter(Year == 2007)
prodaja2009 <- letna.prodaja %>%filter(Year == 2009)

sprememba <- (prodaja2009$Annual - prodaja2007$Annual)/(prodaja2007$Annual) * 100 #sprememba v procentih 
sprememba.prodaje <- data.frame(unique(letna.prodaja$Country), sprememba)
colnames(sprememba.prodaje)<-c("Country","Sales_change")
sprememba.prodaje$Country <- as.character(sprememba.prodaje$Country)

s <- inner_join(filter(gdp,Year==2009),filter(gdp,Year==2007),by="Country")
sprememba2 <- ( s$GDP.x - s$GDP.y )/s$GDP.y * 100 #sprememba BDP v procenith v letih 2007 na 2009
sprememba.BDP <- data.frame(filter(gdp,Year==2007)$Country, sprememba2)
colnames(sprememba.BDP) <- c("Country","BDP_change")
sprememba.BDP$Country <- as.character(sprememba.BDP$Country)


##popravek imen v tabeli BDP
indexi <- which( is.na( left_join(sprememba.prodaje, sprememba.BDP)$BDP_change)) #indexi kjer se imena drzav iz sprememba.prodaje ne ujemajo s sprememba.BDP
drzave <- sprememba.prodaje$Country[indexi]

for (drzava in drzave){
  mesto <- grep(substr(drzava,1,7),sprememba.BDP$Country)
  sprememba.BDP$Country[mesto] <- drzava
}

ostale.drzave <- c("CONGO KINSHASA","GUIANA","HONG-KONG","IRAK","IVORY COAST","KIRGHIZISTAN",
             "LAOS","MOLDAVIA","TADJIKISTAN","UNITED ARAB EMIRATES","UNITED KINGDOM","VIETNAM","SOUTH KOREA") #preostale drzave, jih je treba ročno
ostale.drzave2 <-c("D.R. OF THE CONGO","GUYANA","CHINA, HONG KONG SAR","IRAQ","CÔTE D'IVOIRE",
                   "KYRGYZSTAN","LAO PEOPLE'S DR","REPUBLIC OF MOLDOVA","TAJIKISTAN","UNITED ARAB EMIRATES","UNITED KINGDOM","VIET NAM","REPUBLIC OF KOREA")

i = 1
for (drzava in ostale.drzave2){
  sprememba.BDP$Country[ grep(drzava, sprememba.BDP$Country) ] <- ostale.drzave[i]
  i = i + 1
}

sprememba <- left_join(sprememba.prodaje,sprememba.BDP)
sprememba <- sprememba[-which(is.na(sprememba$BDP_change)),]

##Razvrščanje držav glede na vpliv krize na prodajo 

k <- kmeans(scale(sprememba.prodaje$Sales_change), 7, nstart = 1000)
skupine <- data.frame(Country=sprememba.prodaje$Country, Group = factor(k$cluster))



##korelacija med spremembo gospodarkse rasti ter prodajo avtomobilov
cor(sprememba$Sales_change,sprememba$BDP_change)



##Razvrščanje držav glede na število prodanih avtomobilov v letu 2017



