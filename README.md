# Analiza svetovnega avtomobilskega trga

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2016/17

## Tematika

Za predmet analize sem si izbral svetovni avtomobilski trg. S pridobljenimi podatki iz spleta bom analiziral trg iz različnih vidikov kot so svetovna proizvodnja in prodaja, proizvodnja avtomobilov posameznih podjetij, gospodarski prispevki panoge ter število vozil v uporabi. 

Podatke bom v največji meri pridobil iz spletnega portala organizacije proizvajalcev motornih vozil OICA (Organisation Internationale des Constructeurs d'Automobiles) ter Wikipedije. Podatki na spletnem mestu OICA so na voljo v formatu xls, iz Wikipedije pa jih bom pridobil z metodo data scrapping. 

Povezave do podatkovnih virov:
* Spletni portal OICA (http://www.oica.net)
* Wikipedija (https://en.wikipedia.org/wiki/List_of_manufacturers_by_motor_vehicle_production#2015)

Zasnova podatkovnega modela:
* prva tabela - prikaz podatkov o proizvodnji avtomobilov (stolpci: države, leta, tip vozila, proizvodnja avtomobilov)
* druga tabela - prikaz podatkov o prodaji avtomobilov (stolpci: države, leta, tipa vozila, prodaja avtomobilov)
* tretja tabela - prikaz podatkov o številu avtomobilov v uporabi (stolpci: države, leta, tip vozila, avtomobili v uporabi)
* četrta tabela - ekonomski prispevki panoge (stolpci: države, ekonomski prispevek - zaposlenost v panogi, investicije, prihodki)
* peta tabela - proizvodnja posameznih proizvajalcev  (stolpci:proizvajalec, leto, tip vozila, število proizvedenih avtomobilov)

Pri analizi podatkov se bom osredotočil na gibanje količin skozi čas, primerajvo med državami ter proizvajalci in pa povezave med posameznimi kategorijami.


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
