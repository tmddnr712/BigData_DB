shapiro.test(rnorm(1000))
set.seed(450)
x<-runif(50,min=2, max=4)  # 균등분포 
shapiro.test(x)

install.packages("MASS")
library(MASS)
str(Cars93)
head(Cars93)
Cars93$Price
Cars93$Origin
class(Cars93$Price)
class(Cars93$Origin)
levels(Cars93$Origin)
table(Cars93$Origin)
with(Cars93, tapply(Price, Origin, summary))
boxplot(Price ~ Origin, data=Cars93, main="원산지별 가격", xlab="원산지", ylab="가격")
with(Cars93, tapply(Price, Origin, shapiro.test))
# 귀무가설 : 정규분포이다. 대립가설 : 정규분포가 아니다.
# 정규분포가 아니다.

var.test(Price ~ Origin, data=Cars93)
wilcox.test(Price ~ Origin, data=Cars93, alternative=c("two.sided"),
            var.equal=F, exact=F, conf.lvel=0.95)
# 가설설정
  # 귀무가설(H0): 미국산과 외국산에 대한 원산지별 가격차이가 없다.
  # 연구가설(H1): 미국산과 외국산에 대한 원산지별 가격차이가 있다.
  # 연구환경: 미국내에서 판매되고 있는 자동차에 대하여 원산지별 가격차이가 발생하고 있다는
  #           여론이 있어 이를 확인하고자 원산지별 자동차 가격을 수집하여 검정을 실시
  # 유의 수준: 0.05
  # 분석 방법: 비모수 평균 검정
  # 검정통계량: w = 1024.5
  # 유의확률: p-value = 0.6724
  # 결과해석: 유의수준 0.05에서 귀무가설이 기각되지 못하였다.
              # 따라서 미국내에서 판매되고 있는 자동차의 원사지별 가격차이는 없는 것으로 나타났다.
              # 외국산이나 미국산이나 소비자를 동등하게 대하고 있는 것으로 분석된다.

n <- 1000
x <- rnorm(n, mean = 100, sd = 10)
length(x)
hist(x)
shapiro.test(x)
t.test(x, mu=95) # 단일 표본 평균 검정
t.test(x, mu=99.8, conf.level=0.95)
t.test(x, mu=99.8, conf.level=0.99)

data <- read.csv("C:/Users/노승욱/Desktop/R자료/one_sample.csv", header=TRUE)
head(data)
x <- data$survey
summary(x)
table(X) #불만족:0, 만족:1
install.packages("prettyR")
library(prettyR)
binom.test(c(14, 136), p=0.2) # 불만족 20%
# 비율검정
# 귀무가설 : 비율 차이가 나지 않는다.
# 대립가설 : 비율 차이가 난다.

x <- data$time
head(x)
summary(x) #na처리리
mean(x, na.rm=T)
x1 <- na.omit(x)
mean(x1)
shapiro.test(x1)

t.test(x1, mu=5.2) # 일주일에 노동시간(40)
t.test(x1, mu=5.2, alter="two.side", conf.lvel=0.95) #기본값이 양측검정, 신뢰구간 95%
# 유의수준 0.05로 결정
# 방향성이 있는 연구 가설
t.test(x1, mu=5.2, alter="greater", conf.lvel=0.95)

data2 <- read.csv("C:/Users/노승욱/Desktop/R자료/two_sample.csv", header=TRUE)
data
head(data)
dataset <- data2[c('method', 'score')]
table(dataset$method)

(method1 <- subset(dataset, method==1))
(method2 <- subset(dataset, method==2))

(method1_score <- method1$score)
(method2_score <- method2$score)

var.test(method1_score, method2_score) # p-value = 0.3002 등분산성성
t.test(method1_score, method2_score, var.equal = T)
# p-value = 0.04029 두 집단에는 평균차이가 있다.
# method1_score, method2_score 두 방법 중에서 방법1이 방법2보다 더 큰 경우만 고려하면 된다.
# 방향성이 있는 연구 가설
t.test(method1_score, method2_score, alter="greater", var.equal=T)



