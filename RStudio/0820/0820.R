install.packages("e1071")
library(e1071)
?svm

df = data.frame(
  x1 = c(1,2,1,2,4,5,6),
  x2 = c(8,7,5,6,1,3,2),
  y = factor(c(1,1,1,1,0,0,0))
)
df
model_svm = svm(y ~ ., data = df)

model_svm # type : C-classfication 0 ~ 무한대, kernel : radial 방사형커널
summary(model_svm)

par(mfrow=c(1,1))
plot(df$x1, df$x2, col=df$y)
x11()
plot(model_svm, df)

###
data(iris)
set.seed(415)
idx = sample(1:nrow(iris), 0.7 * nrow(iris))
training = iris[idx,]
testing = iris[-idx,]
training
testing

dim(training)
dim(testing)

# 디폴프 parameter로 학습
model_svm = svm(Species ~ ., data = training, na.action = na.omit)
summary(model_svm)

pred <- predict(model_svm, testing)

table(pred, testing$Species)

tuning <- tune.svm(Species ~., data = training,
                   gamma = 10^(-5:1), cost=10^(-2:3))
tuning
#tuning 후 결정된 parameter로 학습
model_svm2 = svm(Species ~ ., data = training,
                 gamma = 0.1,
                 cost = 100,
                 na.action = na.omit)
pred2 <- predict(model_svm2, testing)
tb <- table(pred2, testing$Species)
(12+13+17) / nrow(testing)
#정분류 문제는 없고 오분에 대하여 디폴트와 다른 결과가 나옴
sum(diag(tb)) / nrow(testing)

# 문제
weatherAUS <- read.csv("C:/Users/노승욱/Desktop/R자료/weatherAUS.csv")
weatherAUS
str(weatherAUS)
names(weatherAUS)
weatherAUS$RainTomorrow <- as.factor(weatherAUS$RainTomorrow)
set.seed(415)
idx = sample(1:nrow(weatherAUS), 0.7 * nrow(weatherAUS))
training_w = weatherAUS[idx,]
testing_w = weatherAUS[-idx,]

training_w = na.omit(training_w)
testing_w = na.omit(testing_w)

# tuning 범위를 많이 주면 조합이 많아서 시간이 많이 걸림
tuning <- tune.svm(RainTomorrow ~., data = training_w,
                   gamma = 10^(-1:1), cost=10^(0:3))
tuning
model_svm2 = svm(RainTomorrow ~ ., data = training_w,
                 gamma = 0.1,
                 cost = 100,
                 na.action = na.omit)
pred2 <- predict(model_svm2, testing_w)
tb <- table(pred2, testing$Species)
table(pred2, testing_w$Species)

#caret을 이용한 svm분석
install.packages("mlbench")
library(mlbench)
data(Sonar)
str(Sonar)
install.packages("caret")
library(caret)
set.seed(998)
inTraining <- createDataPartition(Sonar$Class, p = .75, list = FALSE)
training <- Sonar[inTraining,]
testing <- Sonar[-inTraining,]
svmControl <- trainControl(method = "repeatedcv",
                           number = 10, repeats = 10,
                           classProbs = TRUE,
                           summaryFunction = twoClassSummary,
                           search = "random")
set.seed(825)
# svmRadial, svmLinear, svmPoly 에 대한 파라미터 최적화 결과가 다름
svmFit <- train(Class ~., data = training,
                method = "svmRadial",
                trControl = svmControl,
                preProc = c("center", "scale"),
                metric = "ROC",
                tuenLength = 15)
svmFit$bestTune
sonar_p <- predict(svmFit, newdata = testing)
head(sonar_p)
table(sonar_p, testing$Class)
confusionMatrix(sonar_p, testing$Class)
