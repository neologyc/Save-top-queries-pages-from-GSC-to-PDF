
# vytažení dat pro graf pro jedno klíčové slovo
get_data_per_keyword <- function( query ) {
  filter <- c("country==cze", paste0("query==", query))
  data <- searchConsoleR::search_analytics(siteUrl, dateFrom, dateTo,
                                           dimensions = c( "query", "date"),
                                           searchType = "web",
                                           dimensionFilterExp = filter,
                                           rowLimit = 1000)
  
  
  return(data)
}

# vytažení dat pro graf pro jednu stránku
get_data_per_page <- function( page ) {
  filter <- c("country==cze", paste0("page==", page))
  data <- searchConsoleR::search_analytics(siteUrl, dateFrom, dateTo,
                                           dimensions = c( "page", "date"),
                                           searchType = "web",
                                           dimensionFilterExp = filter,
                                           rowLimit = 1000)
  
  
  return(data)
}