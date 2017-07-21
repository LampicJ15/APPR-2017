library(readr)
library(dplyr)
library(ggplot2)
library(rworldmap)
library(maps)

uporaba <- read.csv2("podatki/urejeni/uporaba.csv")


########################################################################################################################################################

#Analiza uporabe
letna.uporaba <- uporaba %>% group_by(Country,Year) %>% summarise( Annual = sum(Number)) 

sprememba.uporabe <- data.frame(unique(letna.uporaba$Country), 2005, 0)
colnames(sprememba.uporabe) <- c("Country","Year","Use_change")
sprememba.uporabe$Country <- as.character(sprememba.uporabe$Country )

for (leto in 2005:2013){
  sprememba <- (filter(letna.uporaba, Year==(leto + 1))$Annual - filter(letna.uporaba, Year==leto)$Annual)/filter(letna.uporaba, Year==leto)$Annual * 100 #sprememba uporabe v dveh zaporednih letih v procentih
  sprememba <- data.frame(unique(letna.uporaba$Country),(leto+1), sprememba)
  colnames(sprememba) <- c("Country","Year","Use_change")
  sprememba.uporabe <- rbind(sprememba.uporabe, sprememba)
  
}

#Največji padec v uporabi avtomobilov
padec <- sprememba.uporabe[which.min(sprememba.uporabe$Use_change),]

#Največji porast v uporabi avtomobilov
sprememba.uporabe <- sprememba.uporabe[-grep("GHANA",sprememba.uporabe$Country),]
porast <- sprememba.uporabe[which.max(sprememba.uporabe$Use_change),]

###########################################################################################################################################################
##sprememba uporabe od leta 2005 do 2014

sprememba <- (filter(letna.uporaba, Year==(2014))$Annual - filter(letna.uporaba, Year==2005)$Annual)/filter(letna.uporaba, Year==2005)$Annual * 100
sprememba <- data.frame(unique(letna.uporaba$Country), sprememba)
colnames(sprememba) <- c("Country","Use_change")
sprememba$Country <- as.character(sprememba$Country)

##razvrščanje na skupine glede na spremembo uporabe
k <- kmeans(scale(sprememba$Use_change), 7, nstart = 1000)
skupine <- data.frame(Country=sprememba$Country, Group = factor(k$cluster))
skupine$Country <- as.character(skupine$Country)

##zemljevid
world <- map_data("world")
world<-world[c(1:5)]
colnames(world) <-c("long","lat","group","order","Country")
world$Country <- toupper(world$Country)

##poravek imen 
drzave <- c("AZERBAIDJAN","BOSNIA","CONGO (RDC)","MOLDAVIA","UNITED KINGDOM","UNITED STATES OF AMERICA")
popravki <- c("AZERBAIJAN","BOSNIA AND HERZEGOVINA","DEMOCRATIC REPUBLIC OF THE CONGO","MOLDOVA","UK","USA")
i = 1
for (drzava in drzave){
  skupine$Country[grep(drzava,skupine$Country)] <- popravki[i]
  i = i + 1
}
skupine <- left_join(world,skupine,by="Country")
map3 <- ggplot() + geom_polygon(data = skupine,aes(x=long, y = lat, group = group,fill=Group)) + scale_fill_discrete(name="Skupina")

##največje spremembi uporabe
upad <- sprememba[which.min(sprememba$Use_change),]
porast2 <- sprememba[which.max(sprememba$Use_change),]







