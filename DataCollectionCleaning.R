
library(dplyr)
library(MASS)

# Collecting and cleaning data on bigram freq from web
mono_url <- "http://practicalcryptography.com/media/cryptanalysis/files/LANG_monograms.txt"
bi_url <- "http://practicalcryptography.com/media/cryptanalysis/files/LANG_bigrams.txt"
tri_url <- "http://practicalcryptography.com/media/cryptanalysis/files/LANG_trigrams.txt.zip"

languages <- c("danish", "english", "finnish", "french", "german", 
               "icelandic", "polish", "spanish", "swedish")
# had to remove "russian"

readURL <- function(x) read.csv(x, header = F, as.is = T, sep = " ", na.strings = "Na")

for(i in 1:length(languages)){
  mono <- readURL(sub("LANG", languages[i], mono_url))
  bi <- readURL(sub("LANG", languages[i], bi_url))
  tri <- readURL(unzip(sub("LANG", languages[i], tri_url)))
  thisLang <- rbind(mono, tri)
  names(thisLang) <- c("letter", languages[i])
  if(i == 1){ langDat <- thisLang }else
    if(i > 1){ langDat <- inner_join(langDat, thisLang) }
}

langDatVals <- langDat[,2:length(langDat)]
head(langDatVals)

# calculate proportions 
scaledLangDatVals <- langDatVals
totals <- colSums(langDatVals)
for(i in 1:ncol(langDatVals)){
  scaledLangDatVals[,i] <- langDatVals[,i] / totals[i]
}

image(as.matrix(scaledLangDatVals))
head(scaledLangDatVals)

# calculate distances
dists <- dist(t(scaledLangDatVals))
mds <- isoMDS(dists)

# plot
plot(mds$points, type = "n")
text(mds$points[,1], mds$points[,2], rownames(mds$points))

