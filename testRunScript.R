fake <- read.csv("fakeTrainData1.csv")
real <- read.csv("realTrainData1.csv")
df <- rbind(fake, real)

test <- read.csv("testData1b.csv")
testFake <- subset(test, test$realFAKEcat=="fake")
testReal <- subset(test, test$realFAKEcat=="real")
testFake0 <- testFake
testReal0 <- testReal
testFake0$last <- as.numeric(0)
testReal0$last <- as.numeric(1)
test0 <- rbind(testFake0, testReal0)



library(party)
df.tree <- ctree(realFAKEcat ~ . , data = df[,-c(1)])
plot(df.tree)

library(rpart)
df.part <- rpart(realFAKEcat ~ joy + anger + sadness + trust + fear + negative + surprise + positive + disgust, df[,-c(1)], na.action = na.rpart)
library(rpart.plot)
rpart.plot(df.part,digits=10,fallen.leaves=TRUE,type=4)

real0 <- real
fake0 <- fake
real0$last <- as.numeric(1)
fake0$last <- as.numeric(0)
df0 <- rbind(fake0, real0)
df0.binom <- glm(df0$last ~ ., data = df0[,-c(1,12)],family = "binomial")
summary(df0.binom)
anova(df0.binom, test="Chisq")

df0.binom.predict <- predict(df0.binom,newdata=subset(test0,select=-c(1,12)),type='response')
df0.binom.predict.res <- ifelse(df0.binom.predict > 0.5,1,0)
df0.binom.predict.ERR <- mean(df0.binom.predict.res != test0$last)
print(paste('Accuracy',1-df0.binom.predict.ERR))


library(randomForest)
df0.forest <- randomForest(realFAKEcat ~. , test)

