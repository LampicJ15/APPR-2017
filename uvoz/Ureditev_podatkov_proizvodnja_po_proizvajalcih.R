##Pridobivanje tabel iz spletne strani (Podatki o proizvodnji avtomobilov po proizvajalcih)

library(rvest)
library(gsubfn)
library(readr)
library(dplyr)

link <- "https://en.wikipedia.org/wiki/List_of_manufacturers_by_motor_vehicle_production#2015"
stran <- html_session(link) %>% read_html()

pro2015 <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[1]] %>% html_table(dec = ",")

pro2015 <- pro2015[c(2,3,4)]
colnames(pro2015) <- c("Group","Country","Number")
pro2015$Year <- rep(2015, length(pro2015[[1]]))
pro2015 <- pro2015[c(1,4,2,3)]


pro2014 <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[2]] %>% html_table(dec = ",")
pro2014 <- pro2014[c(2,3,4)]
colnames(pro2014) <- c("Group","Country","Number")
pro2014$Year <- rep(2014, length(pro2014[[1]]))
pro2014 <- pro2014[c(1,4,2,3)]


pro2013 <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[3]] %>% html_table(dec = ",")
pro2013 <- pro2013[c(2,3,4)]
colnames(pro2013) <- c("Group","Country","Number")
pro2013$Year <- rep(2013, length(pro2013[[1]]))
pro2013 <- pro2013[c(1,4,2,3)]


pro2012 <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[4]] %>% html_table(dec = ",")
pro2012 <- pro2012[c(2,3,4)]
colnames(pro2012) <- c("Group","Country","Number")
pro2012$Year <- rep(2012, length(pro2012[[1]]))
pro2012 <- pro2012[c(1,4,2,3)]


pro2008 <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[5]] %>% html_table(dec = ",")
pro2008 <- pro2008[c(2,3,4)]
colnames(pro2008) <- c("Group","Country","Number")
pro2008$Year <- rep(2008, length(pro2008[[1]]))
pro2008 <- pro2008[c(1,4,2,3)]


pro2007 <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[6]] %>% html_table(dec = ",")
pro2007 <- pro2007[c(2,3,4)]
colnames(pro2007) <- c("Group","Country","Number")
pro2007$Year <- rep(2007, length(pro2007[[1]]))
pro2007 <- pro2007[c(1,4,2,3)]


pro2006 <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[7]] %>% html_table(dec = ",")
pro2006 <- pro2006[c(2,3,4)]
colnames(pro2006) <- c("Group","Country","Number")
pro2006$Year <- rep(2006, length(pro2006[[1]]))
pro2006 <- pro2006[c(1,4,2,3)]


pro2005 <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[8]] %>% html_table(dec = ",")
pro2005 <- pro2005[c(2,3,4)]
colnames(pro2006) <- c("Group","Country","Number")
pro2005$Year <- rep(2005, length(pro2005[[1]]))
pro2005 <- pro2005[c(1,4,2,3)]

pro2004 <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[9]] %>% html_table(dec = ",")
pro2004 <- pro2004[c(2,3,4)]
colnames(pro2004) <- c("Group","Country","Number")
pro2004$Year <- rep(2004, length(pro2004[[1]]))
pro2004 <- pro2004[c(1,4,2,3)]

#########################################################################################


pro2011 <- stran %>% html_nodes(xpath="//table[@class='toccolours nowraplinks']") %>%
  .[[1]] %>% html_table(dec = ",",fill=TRUE)

pro2011 <- pro2011[c(1,length(pro2011)-5)]


pro2010 <- stran %>% html_nodes(xpath="//table[@class='toccolours nowraplinks']") %>%
  .[[2]] %>% html_table(dec = ",",fill=TRUE)

pro2010 <- pro2010[c(1,length(pro2010)-5)]

pro2009 <- stran %>% html_nodes(xpath="//table[@class='toccolours nowraplinks']") %>%
  .[[3]] %>% html_table(dec = ",",fill=TRUE)

pro2009 <- pro2009[c(1,length(pro2009)-5)]



