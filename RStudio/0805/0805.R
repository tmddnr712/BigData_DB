insurance <- read.csv("C:/Users/노승욱/Desktop/R자료/insurance.csv", header = T, stringsAsFactor = F)
str(insurance)
insurance$sex = as.factor(insurance$sex)
insurance$smoker = as.factor(insurance$smoker) # 범주형
insurance$region = as.factor(insurance$region) # 범주형
str(insurance)
levels(insurance$region)
summary(insurance)
insurance2 <- insurance[, c(1,3:7)] # domain knowledge => 전산
# 2회귀모델 생성
model_ins2 <- lm(charges ~. , data = insurance2)
model_ins2
# 흡연자인 경우 : 23836.3
# northeast
x <-c('yes', 'no')
insurance2$smoker <-factor(insurance2$smoker, levels=x)
head(insurance2)
str(insurance2$smoker)
model_ins2 <-lm(charges ~., data=insurance2)
model_ins2
summary(model_ins2)
region1 <- numeric()
region2 <- numeric()
region3 <- numeric()

# 3 더미변수화 
idx <- 1
for(re in insurance$region){
  if(re == 'northeast'){
    region1[idx] <- 0
    region2[idx] <- 0
    region3[idx] <- 0
  }
  else if(re == 'northwest'){
    region1[idx] <- 1
    region2[idx] <- 0
    region3[idx] <- 0
  }
  else if(re == 'southeast'){
    region1[idx] <- 0
    region2[idx] <- 1
    region3[idx] <- 0
  }
  else if(re == 'southwest'){
    region1[idx] <- 0
    region2[idx] <- 0
    region3[idx] <- 1
  }
  idx = idx + 1
}
table(region1)
table(region2)
table(region3)
tot <- nrow(insurance2)
tot - (table(region1)[2] + table(region2)[2] + table(region3)[3])  

# 3. 파생변수 (n-1 개의 더미변수를 생성)
insurance$region1 <- region1
insurance$region2 <- region2
insurance$region3 <- region3
head(insurance)

# 회귀 분석, 신경망에서는 dummy 변수화에 신경써야 함
insurance_train <- insurance[, -c(2, 6)]
head(insurance_train)
model_ins <- lm(charges ~ . , data = insurance_train)
model_ins

# 범주형 변수 0.1
# 있고 없고 기울기에 영향을 주지 않고 상수 역할
# 거주 지역에 따라서 의료 감소 영향이 있음 southeast 지역이 의료비가 가장 많이 절감
y = -11990.3 + (257 * age) + (338.7 * bmi) + (474.6 * children) + (23836.3(smokeryes) + (-352.2 * region1))


# Boston Dataset 을 이용한 집값예측
install.packages("MASS")
library(MASS)
data("Boston")
help("Boston")
str(Boston)
head(Boston, 3)
class(Boston)

class(scale(Boston))
boston_df <- as.data.frame(scale(Boston))
head(boston_df)
# sampling : 과적합을 방지하기 위해 train / test 나눔
set.seed(123)
idx <- sample(1:nrow(boston_df), 300)
trainDF <- boston_df[idx,]
testDF <- boston_df[-idx,]
dim(trainDF); dim(testDF)
# Boston : 보스턴 시 주택 가격 데이터
# 주택 가격에 영향을 미치는 요소를 분석하고자 하는 목적으로 사용 
# 회귀분석에 활용 
# 범죄율, 학생vs교사 비율 등 보스턴 주택 가격의 중앙값(median value)
# 전제 : 주택가격에 영향을 미치는 요소에 대하여 연구
# 변수를 다음의 것으로 결정하였다. => 주택가격에 어떤영향을 미치는가. ?
# 교통, 쾌적한 환경, 경관, 주택의 구조, 교육환경, 부랑아 비율, 
#crim : 도시 1인당 범죄율 
#zn :   25,000 평방피트를 초과하는 거주지역 비율
#indus :비상업지역이 점유하고 있는 토지 비율  
#chas : 찰스강에 대한 더미변수(1:강의 경계 위치, 0:아닌 경우) #애는 제
# nox : 10ppm 당 농축 일산화질소 
#rm : 주택 1가구당 평균 방의 개수 
#age : 1940년 이전에 건축된 소유주택 비율 
#dis : 5개 보스턴 직업센터까지의 접근성 지수  
#rad : 고속도로 접근성 지수 
#tax : 10,000 달러 당 재산세율 
#ptratio : 도시별 학생/교사 비율 
#black : 자치 도시별 흑인 비율 
#lstat : 하위계층 비율 
#medv : 소유 주택가격 중앙값 (단위 : $1,000)
