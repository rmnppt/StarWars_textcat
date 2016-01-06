
### scrape the SW character names from Wikipedia

library(rvest)

swChars <- html("https://en.wikipedia.org/wiki/List_of_Star_Wars_characters")

swNames <- swChars %>% 
  html_nodes("dt") %>%
  html_text()

for(i in 1:length(swNames)){
  swNames[i] <- strsplit(enc2utf8(swNames[i]), "—")[[1]][1]
}


