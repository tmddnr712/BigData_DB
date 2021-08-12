install.packages("caret")
install.packages("e1071")
library(caret)
library(e1071)
data(iris)
str(iris)
TrainData <- iris[,1:4]
TrainClasses <- iris[,5]
# kernel density estimation 보간법
featurePlot(TrainData, TrainClasses, plot="density", auto.key=list(coulmns=3))
modelLookup("knn")
knnFit1 <- train(TrainData, TrainClasses,
                 method = "knn",
                 preProcess = c("center", "scale"), #z-점수 scaling
                 tuneLength = 5,
                 trControl = trainControl(method = "cv"))
knnPredict <- predict(knnFit1, newdata = TrainData)
confusionMatrix(knnPredict, TrainClasses)
mean(knnPredict == TrainClasses) # TRUE(1) / FALSE(0)
# boolean vector : c(1,0,1,0,1,1,1,1)

x <- iris[,-5]
y <- iris[,5]
# bootstraping(변수조합)
obj2 <- tune.knn(x, y, k = 5:25, tunecontrol = tune.control(sampling = "boot"))
summary(obj2)
plot(obj2)


normalize <- function(x){
  return((x-min(x)) / (max(x) - min(x)))
}


weather <- read.csv("C:/Users/노승욱/Desktop/R자료/weatherAUS.csv")
str(weather)
weather <- weather[,c(-1,-2,-8,-10,-11,-22)]
weather <- na.omit(weather)
table(weather$RainTomorrow)
weather$RainTomorrow <- as.factor(weather$RainTomorrow)
weather_n <- as.data.frame(apply(weather[1:17], normalize))
# 데이터 분할
idx <- sample(1:nrow(weather_n), nrow(weather_m)*0.7)
weather_train <- weather_n[idx,]
weather_test <- weather_n[-idx,]
