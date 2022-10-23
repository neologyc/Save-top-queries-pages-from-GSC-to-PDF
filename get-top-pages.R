# Knihovny, které potřebujete
library(ggplot2)
library(dplyr)
library(searchConsoleR)
library(gridExtra)
library(grid)
library(scales)
library(stringr)


# načtení důležitých funkcí z externího souboru
source("functions.R")

# přihlášení do Google Search Console
scr_auth(email = "jaroslav.hlavinka@firma.seznam.cz")

# nastavení pro extrakci dat z Google Search Console
siteUrl <<- "sc-domain:volnamista.cz"

# období, za které se vytahují data
dateTo <<- Sys.Date()
dateFrom <<- dateTo - 485 # za celou dobu

# počet řádků, které vytáhneme z Google Search Console
resultsCount <<- 100

# filtrace Google Search Console - chceme data jen pro Česko. Pokud máte zahraniční web, je potřeba toto změnit
filter <- "country==cze"

# nastavení vzhledu grafů
theme_set(theme_classic())

# vytažení nejnavštěvovanějších vstupních stránek podle kliků
data <- searchConsoleR::search_analytics(siteUrl, 
                                                 dateFrom, 
                                                 dateTo,
                                                 dimensions = c( "page"),
                                                 searchType = "web",
                                                 dimensionFilterExp = filter,
                                                 rowLimit = resultsCount)

# náhled získaných dat pro kontrolu
head(data, 20)

# ukládání do PDFka
pdf( paste("./exports/top-landing-pages-", str_replace_all(siteUrl, "[.:/]" ,"-"),"-", dateTo, ".pdf", sep=""), onefile = TRUE, width=16 , height=10)

# nastavení countu
count <- 1

# vytažení dat po jednotlivých vstupních stránkách z GSC
for (page in data$page) {
  # typeof(page)
  page = toString(page)
  print(count)
  print(page)
  
  page_data <- get_data_per_page(page)
  
  # sort dat podle datumu
  page_data <- page_data[order(page_data$date),]
  
  # příprava dat pro grafování
  gsc.data <- data.frame(date = page_data$date, 
                         page = page_data$page, 
                         clicks = page_data$clicks, 
                         impressions = page_data$impressions, 
                         ctr = page_data$ctr, 
                         position = page_data$position
  )
  
  #grafování
  p1 <- ggplot( gsc.data, aes(x=date)) + 
    geom_line(aes(y = position), color = "#E8710A", lwd=1.0005) + 
    scale_y_reverse( breaks= pretty_breaks() ) + 
    scale_x_date(date_breaks = "2 weeks" , date_labels = "%d-%m", expand = c(0, 5)) +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5)) +
    theme(axis.title.x = element_blank()) +
    labs( title = paste0 (page, "; kliků: ", sum(gsc.data$clicks), 
                          "; impresí: ", sum(gsc.data$impressions), 
                          "; CTR: ", percent(round(mean(gsc.data$ctr), digits = 2)), 
                          "; pozice: ", round(mean(gsc.data$position), digits = 2) )) +
    geom_hline(aes(yintercept = mean(position)))
  
  p2 <- ggplot( gsc.data, aes(x=date)) + 
    geom_line(aes(y = impressions), color = "#5E35B1", lwd=1.0005) +
    scale_x_date(date_breaks = "2 weeks" , date_labels = "%d-%m", expand = c(0, 5)) +
    theme(axis.title.x = element_blank()) +
    scale_y_continuous(breaks= pretty_breaks()) +
    geom_hline(aes(yintercept = mean(impressions))) + 
    theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
  
  p3 <- ggplot( gsc.data, aes(x=date)) + 
    geom_line(aes(y = clicks), color = "#4285F4", lwd=1.0005) +
    scale_x_date(date_breaks = "2 weeks" , date_labels = "%d-%m", expand = c(0, 5)) +
    theme(axis.title.x = element_blank()) +
    scale_y_continuous(breaks= pretty_breaks()) +
    geom_hline(aes(yintercept = mean(clicks))) + 
    theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
  
  p4 <- ggplot( gsc.data, aes(x=date)) + 
    geom_line(aes(y = ctr), color = "#00897B", lwd=1.0005) +
    scale_x_date(date_breaks = "2 weeks" , date_labels = "%d-%m", expand = c(0, 5)) +
    theme(axis.title.x = element_blank()) +
    scale_y_continuous(labels = percent_format(accuracy = 1)) +
    geom_hline(aes(yintercept = mean(ctr))) + 
    theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
  
  grid.newpage()
  grid.draw(rbind(ggplotGrob(p1), ggplotGrob(p2), ggplotGrob(p3), ggplotGrob(p4), size = "last"))
  
  count = count + 1
}
# TEĎ ČEKEJ, než dojede log v consoli níže

# finální uložení PDFka
dev.off()

# PDF najdete ve složce /exports/