#install.packages("party")
library(party)
data1 <- read.csv(file.choose())
data2 <- read.csv(file.choose())
finaldata1 <- rbind(data1, data2)
#print(finaldata1)
output.tree2 <- ctree(realFAKEcat ~ . , data = finaldata1[,-c(1)])
plot(output.tree2)

