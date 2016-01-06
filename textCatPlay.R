
# try using ngram data from texcat
library(MASS)
library(textcat)
library(dplyr)
library(ggplot2)

charNames <- read.csv("Data/star_wars_dataframe.csv", 
                      header = F, as.is = T, sep = "\t", skip = 1)
dim(charNames)
names(charNames) <- c("name", "desc")

ds <- textcat_xdist(TC_char_profiles)
mds <- isoMDS(ds)
x <- mds$points[,1]
y <- mds$points[,2]

plot(NA, axes = F, ann = F, xlim = range(x), ylim = range(y))
text(x, y, rownames(mds$points))

charNames$langCat <- ""
for(i in 1:nrow(charNames)){
  charNames$langCat[i] <- textcat(charNames$name[i])
}

write.csv(charNames, "Data/names_categorised.csv")

counts <- data.frame(table(charNames$langCat))
names(counts)[1] <- "language"
counts$language <- reorder(counts$language, counts$Freq)

ggplot(counts, aes(x = language, y = Freq)) +
  geom_bar(stat = "identity") +
  coord_flip()

charNames$name[which(charNames$langCat == "english")]
charNames$name[which(charNames$langCat == "german")]

charNames[grep("Skywalker", charNames$name),]
charNames[grep("Vader", charNames$name),]
 