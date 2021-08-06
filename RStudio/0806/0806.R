#################################################################
set.seed(137)
probs2 <- runif(100)
labels2 <- as.factor(ifelse(probs2 > .5 & runif(100)< .4, "A","B"))

pred2 <- prediction(probs2, labels2)
plot(performance(pred2, "tpr", "fpr"))
plot(performance(pred, "acc", "cutoff"))
performance(pred, "auc")
##################################################################

# Logistic regression
# 일반 회귀 분석과 동일하게 종속 변수(factor형)와 독립변수(연속형)간의 관계를 나타내며
# 예측 모델을 생성
# 데이터의 결과가 특정 분류로 나누어지기 때문에 분류 분석 방법으로 분류됨
# 이항형으로 (yes/no)로 분류
# 따르는 분포는 이항분포
# consufionMatrix:
# 정분류율(Accuracy), 오분류율,
# 정밀도(precision), True로 예측한 것중에 얼마나 맞추었나
# 민감도(sensitivity), 암을 암으로
# 특이도(specificity), 음성을 음성으로
Dine <- matrix(c(0,17,0,19,0,20.5,0,21.5,0,22,1,24,1,25,0,25,0,27,1,
                 28,1,30,0,31.5,1,32,1,34,1,35,1,36.5,1,39,1,40,1,44), nc=2, byrow=T)
Dine

# 소득에 따른 외식 여부의 결정
colnames(Dine) <-c("Class", "Income")
(Dine <- as.data.frame(Dine))

# 로지스틱 회귀 명령
Logit.model <- glm(Class~Income, family="binomial", data=Dine)
summary(Logit.model)
Logit.model$coeff[1]
Logit.model$coeff[2] #0.3476115 log를 취한 결과값값

#결과를 지수화 하는 이유:
OR <- exp(Logit.model$coeff[2]) # 소득의 1.4배가 되어야 외식을 하겠다.
OR


##################
weather <- read.csv("C:/Users/노승욱/Desktop/R자료/weather.csv", stringsAsFactors = F)
dim(weather)
head(weather)
str(weather)
weather_df <- weather[,c(-1, -6, -8, -14)]
str(weather_df)
weather_df$RainTomorrow[weather_df$RainTomorrow=="Yes"] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow=="No"] <- 0
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow)
head(weather_df)

# 데이터 샘플링
sum(is.na(weather_df))
weather_df <- na.omit(weather_df)
idx <- sample(1:nrow(weather_df), nrow(weather_df)* 0.7)
train <- weather_df[idx,]
test <- weather_df[-idx,]

# 로지스틱 회귀 모델 생성 : 학습 데이터
weather_model <- glm(RainTomorrow ~ ., data=train, family = 'binomial')
weather_model
summary(weather_model)

# 예측치 생성
pred <- predict(weather_model, newdata=test, type="response")
pred
summary(pred)
str(pred)



# 예측치 변환
cpred <- ifelse(pred >= 0.5, 1, 0)
table(cpred)

t <- table(cpred, test$RainTomorrow)
t
sum(diag(t)) / nrow(test)


mean(test == t)
mean(test != t)
# 민감도와 특이도와의 관계에서 평가 모델을 제공 : ROC
install.packages("ROCR")
#update.packages("ROCR")
library(ROCR)
length(cpred)
length(test$RainTomorrow)
sum(is.na(pred))
# 왜 na가 있을까.
sum(is.na(test$RainTomorrow))
(pr <- prediction(pred, test$RainTomorrow))
pfr <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(pfr)

install.packages("pscl")
library(pscl)
pR2(weather_model)

###################################################
install.packages("nnet") # 신경망 패키지지
library(nnet)
data("iris")
str(iris)
idx <- sample(1:nrow(iris), nrow(iris)*0.7)
train <- iris[idx,]
test <- iris[-idx,]
mode1 <- multinom(Species ~ ., data= train)
fit <-mode1$fitted.values
head(fit)
# softmax 함수
fit_pred <- ifelse(fit[,1]> 0.5, 'setosa',
                   ifelse(fit[,2]>=0.5, 'versicolor','virginica'))
pred_prob <- predict(mode1, newdata=test, type="probs")
fit_pred <-ifelse(pred_prob[,1]>=0.5, 'setosa',
                  ifelse(pred_prob[,2]>=0.5, 'versicolor','virginica'))
table(fit_pred, test$Species)

# 정분류
sum(diag(table(fit_pred, test$Species))) / nrow(test) # 테스트 정분류율

#####################################################
# 전처리 명령들을 이용해서 적합하게 데이터를 변형하고 처리한 다음 logistic regression 실시하고
# 정분율이 얼마나 되는지 확인
install.packages("ISLR")
library(ISLR)
Smarket
dim(Smarket)
str(Smarket)
#
attach(Smarket)
plot(Volume)
# lag 시차
glm.fit <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Volume, data = Smarket, family = binomial())
summary(glm.fit)
exp(coef(glm.fit))
glm.probs <- predict(glm.fit, type="response")
residuals(glm.fit, type="deviance")
(glm.pred <- rep("Down", dim(Smarket)[1]))
(glm.pred[glm.probs>0.5]<- "Up")
res <- table(glm.pred, Direction)
res

sum(diag(res)) / sum(res)
detach(Smarket)


# 문제
# class : 암여부(1.폐암, 2: 폐암아님)
# breastcan_t.csv : train 10로 구분해서 int 형으로 데이터 설정: 독립변수 - 연속형
# breastcan_te.csv : test
# logistic regression 으로 모델 생성
# 테스트 데이터에 대하여 accuracy 출력

cancer_train <- read.csv("C:/Users/노승욱/Desktop/R자료/breastcan_t.csv", stringsAsFactors = F)
cancer_test <- read.csv("C:/Users/노승욱/Desktop/R자료/breastcan_te.csv", stringsAsFactors = F)
dim(cancer_train)
dim(cancer_test)
str(cancer_train)
str(cancer_test)
head(cancer_train)
head(cancer_test)

cancer_model <- glm(Class ~ ., data=cancer_train, family = 'binomial')
cancer_model
summary(cancer_model)

# 예측치 생성
pred <- predict(cancer_model, newdata=cancer_test, type="response")
pred
summary(pred)
str(pred)

# 예측치 변환
cpred <- ifelse(pred >= 0.5, 1, 0)
table(cpred)

t <- table(cpred, cancer_test$Class)
t
sum(diag(t)) / nrow(cancer_test)

# 민감도와 특이도와의 관계에서 평가 모델을 제공 : ROC
(pr <- prediction(pred, cancer_test$Class))
pfr <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(pfr)

# accuracy
mean(cancer_test == t)
mean(cancer_test != t)
