library(party)
library(randomForest)
data1 <- read.csv(file.choose())
data2 <- read.csv(file.choose())
finaldata1 <- rbind(data1, data2)
output.forest <- randomForest(realFAKEcat ~ . , data = finaldata1[,-c(1)])
print(output.forest)


