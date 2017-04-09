# Analiza svetovnega avtomobilskega trga

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2016/17

## Tematika

Za predmet analize sem si izbral svetovni avtomobilski trg. S pridobljenimi podatki iz spleta bom analiziral trg iz različnih vidikov kot so svetovna proizvodnja in prodaja, proizvodnja avtomobilov posameznih podjetij, gospodarski prispevki panoge ter število vozil v uporabi. 

Podatke bom v največji meri pridobil iz spletnega portala organizacije proizvajalcev motornih vozil OICA (Organisation Internationale des Constructeurs d'Automobiles) ter Wikipedije. Podatki na spletnem mestu OICA so na voljo v formatu xls, iz Wikipedije pa jih bom pridobil z metodo data scrapping. 

Povezave so podatkovnih virov:
* Spletni portal OICA (http://www.oica.net)
* Wikipedija (https://en.wikipedia.org/wiki/List_of_manufacturers_by_motor_vehicle_production#2015)

Podatke nameravam predstaviti z različnimi tabelami ter s pomočjo ostalih aplikacij. V osnovi bi ločil tri tabele:
* 1.tabela - prikaz podatkov o proizvodnji ter prodaji (stolpci: države, leta, tipi vozil, proizvodnja, prodaja, število vozil v uporabi)
* 2.tabela - ekonomski prispevki panoge (stolpci: države, zaposlenost v panogi, investicije, produktivnost)
* 3.tabela - proizvodnja posameznih podjetij (stolpci: leta, tipi votila, število prodanih vozil)

Pri analizi podatkov se bom osredotočil na gibanje količin skozi čas, primerajvo med državami in povezave med posameznimi kategorijami.




## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
