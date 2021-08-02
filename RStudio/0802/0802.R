# 데이터의 정보 파악
data(iris)
head(iris)
str(iris)
summary(iris)
dim(iris)
levels(iris$Species)

# 범위와 1/4 분위수를 출력하시오
score4 <- c(3,3,6,7,7,10,10,10,11,13,30)
(n <- length(score4))
(max(score4)-min(score4))
range(score4)
diff(range(score4))
mean(score4)
median(score4)
order(score4)
var(score4)
sd(Score4)

total <- sum((score4 -mean(score4)) * (score4-mean(score4)))
total/length(score4)

var_val <- total / (length(score4)-1)
sqrt(var_val)
sqrt(total/(length(score4)-1))

quantile(score4)
quantile(score4, 0.25)
fivenum(score4)
fivenum(score4)[4] - fivenum(score4)[2]
IQR(score4)
quantile(score4)[4] - fivenum(score4)[2]
score4 <- c(3,3,6,7,7,10,10,10,11,13,30)
table(score4) # 도수 분포표

#문제 : 이상치의 상한선과 하한선을 계산
(uppercut = fivenum(score4)[4] + 1.5 * IQR(score4))
(lowercut = fivenum(score4)[2] - 1.5 * IQR(score4))
score4>uppercut
score4<lowercut
#dplyr::filter(score4, score4>uppercut)

boxplot(score4)

# 문제
#weatherAUS를 로딩하여 다음과정을 처리하시요
#1) NA수를 세고 결측치 처리
#2) 이상치 확인 및 처리
#3) 데이터 7:3으로 샘플링

install.packages("dplyr")
library(dplyr)
weather = read.csv("C:/Users/노승욱/DB/RStudio/0802/weatherAUS.csv")
str(weather) # 36881 obs. of 24 variables:, 데이터타입
sum(is.na(weather)) # 75908 행을 기준으로 : 한 행에 있는 na를 보이는대로 1개씩 인식
weather <- na.omit(weather)
sum(is.na(weather))
str(weather) #17378 obs. of 24 variables:

#select(weather, MinTemp, MaxTemp)
apply(weather, 2, is.numeric)
str(select_if(weather, is.numeric))
outdata <- select_if(weather, is.numeric)
str(outdata)

# 각 열별로 IQR을 계산하고 3사분위수 1사분위수에 1.5 * IQR값을 계산해 주어야 함
for(i in 1:ncol(outdata) - 1){
  fivenum(outdata[,i])
  uppercut = fivenum(outdata[,i])[4] + 1.5 * IQR(outdata[,i])
  lowercut = fivenum(outdata[,i])[2] - 1.5 * IQR(outdata[,i])
  out <- filter(outdata, outdata[,i] <= uppercut, outdata[,i] >= lowercut)
}
str(out)
head(trees)
summary(trees)
sd(trees$Volume) / mean(trees$Volume)

# 표준오차 : 표본수가 많아 지면 표준편차는 점점 줄어들음 : 표본수를 고려해주어야 함 sqrt(n)
x = c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)
sd(x)
sqrt(length(x))
(sem <- sd(x) / sqrt(length(x)))
# 95% 신뢰구간
mean(x)
c(mean(x) - (2*sem), mean(x) + (2 * sem))
# 99% 신뢰구간
c(mean(x) - (3*sem), mean(x) + (3 * sem))


install.packages("prob")
library(prob)
cards() # 52장
cards(jokers="TRUE")
(cards(makespace = "TRUE"))
tail(cards())
head(cards())

roulette()
roulette(european="TRUE", makespace="TRUE")

urnsamples(1:3, size=2, replace=TRUE, ordered=TRUE) # 복원추출
urnsamples(1:3, size=2, replace=FALSE, ordered=TRUE) # 비복원추출
urnsamples(c("A", "B", "C"), size=2, replace=FALSE, ordered=TRUE)
urnsamples(c("A", "B", "C"), size=2, replace=FALSE, ordered=FALSE)

(s<-tosscoin(2, makespace = TRUE))
s[1:3]

(c<-cards())
subset(c, suit="Heart")
subset(c, rank %in% 7:9)

(s=cards(makespace = TRUE))
(a=subset(s, suit=="Heart")) # 카드 종류가 Heart인 경우
(b=subset(s, rank %in% 7:9)) # 카드 종류가 7,8,9 인 경우
# 카드를 한장 뽑았는데 Heart이거나 7:9가 나올 표본공간은
union(a, b)

# 카드를 한장 뽑았는데 Heart이면서 7:9가 나올 표본 공간은
intersect(a, b)
Prob(a) # club, diamond, heart, spade
Prob(s, suit=="Heart")
Prob(b) # 12 / 52

# 문제 : 카드를 뽑았는데 숫자가 7,8,9 중에 있던데이중에서 하트카드가 나올 확률은? - 조건부 확률
Prob(s, suit=="Heart", givne=rank %in% 7:9) #3 / 12
Prob(union(a,b))
Prob(a) + Prob(b) - Prob(intersect(a,b))
