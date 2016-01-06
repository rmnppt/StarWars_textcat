### finding letter pairs
library(stringr)

word <- "obi-wan kenobi"
letterCombo <- expand.grid(letters, letters)

# function to count the pairs of letters
countPairs <- function(x, combos) {
  counts <- integer(nrow(combos))
  for(i in 1:nrow(combos)) {
    counts[i] <- str_count(x, paste0(combos[i,1], combos[i,2]))
    }
  counts
}

# results
counts <- countPairs(word, letterCombo)
cbind(letterCombo[counts != 0,], counts[counts != 0])


