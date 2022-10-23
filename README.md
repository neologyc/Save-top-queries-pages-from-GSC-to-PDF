Tento projekt získává data z Google Search Console a grafuje je proto, abyste v GSC nemuseli překlikávat mezi jednotlivými klíčovými slovy a stránkami.
Skript si stáhne nejčastější klíčová slova, nebo vstupní stránky za posledních 16 měsíců a k TOP 100 (můžete přenastavit na více/méně) z nich vygeneruje grafy počtu kliků, impresí, CTR a průměrné pozice a udělá grafy, které uloží do PDF.
V PDF jsou čáry v grafech s barvou podle toho, jak je znáte z GSC (přehledné) a obsahují i černou čárů - to je průměr za celé období.
PDF se výrazně rychleji prochází a během pár kliků na šipku vpravo na klávesnici prostránkujete celé PDF a budete mít lepší přehled o tom, co se v Googlu stalo.

### Hodí se mi to:
* když chci vědět, co se za posledních 16 měsíců stalo v in-depth pohledu po jednotlivých stránkách a klíčových slovech
* když chci jednou za měsíc kontinuálně sledovat, co se děje a nechci se spolehnout na data z Collabimu, Marketing Mineru, nebo jiného měření pozic
* když chci analyzovat, co se děje po větší změně na webu
* když chci analyzovat, co se děje po větší změně ve vyhledávačích v detailním pohledu 

### Instalace
Stáhněte si tento projekt do svého RStudio repozitáře.
Spusťte Top100.Rproj - například dvojklikem

### Jak to používat?
* V projektu jsou 2 hlavní soubory 
  * **get-top-pages.R** - vygrafuje data podle vstupních stránek
  * **get-top-phrases.R** - vygrafuje data podle hledaných klíčových slov
* Vyberte si, která data chcete a pole toho si otevřete soubor
* Proklikejte jej tlačítkem "RUN" jak jste v RStudiu zvyklí
* Nastavit lze:
  * řádek 15 - váš email v GSC
  * řádek 18 - doména z GSC - buď "https://www.firmy.cz/", nebo "sc-domain:firmy.cz
  * řádek 25 - počet výsledků, které chcete mít ve finálním PDF
  * řádek 28 - filtr jen na data z ČR. Pro zahraniční web je potřeba toto změnit podle státu, který chcete sledovat
  * řádek 38 - typ dat - buď "web", "image", "news", "video" podle toho, který report chcete
* Po vytažení všech dat, naleznete export ve složce "/exports/". Pojmenování PDF je výstižné.
* v PDF se navigujte tlačítkem "vpravo" na klávesnici. Bude to rychlejší, než scrollovat

### Co s tím?
* Co roste je dobrá práce - pochlubte se
* Co padá je potřeba prozkoumat více do detailu - co se stalo v doub, kdy podle grafu něco propadlo? Jak na webu, tak ve vyhledávačích.

### Roadmapa (spíše tak Q3-Q4 2023)
* Jako vstup použít seznam vlastních URL, nebo klíčových slov
* Vložit do grafu čáry trendových zlomů pro rychlejší identifikaci změn
