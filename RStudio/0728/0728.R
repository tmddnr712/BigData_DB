# 구구단
gugudan <- function(i,j){
  for(x in i){
    cat("**", x, "단 **\n")
    for(y in j){
      cat(x, "*", y, "=", x*y, "\n")
    }
    cat("\n")
  }
}
i<-c(2:9)
j<-c(1:9)
gugudan(i,j)
# R함수의 특징은 명시적으로 리턴하지 않아도 마지막으로 연산한 것이 리턴

# 제곱
pow <- function(x, y = 2){
  result <- x^y
  print(paste(x,"의", y, "승은", result))
}
(a=pow(3))
(pow(3,1))

#분포
coin <-c(2,2,0,1,1,1,2,3,1,2,2,3,3,4,1,3,2,3,3,1,2,2,1,2,2)
(coin.freq<-table(coin))
length(coin.freq)
plot(0:4, coin.freq, main ="4회 동전던지기 결과",xlab="앞면이 나온 횟수",ylab="빈도수",
     ylim=c(1,11),type="l")

# 문제: 입력되는 벡터를 더해주는 함수작성 c(2,5,8,10)을 입력해서 모두 더한 값을 출력
summation <- function(x){
  result = 0
  for(i in 1:length(x))
    result <- result + x[i]
  return(result)
}

y <- c(2,5,8,10)
summation(y)

# 정규화
head(iris)
head(iris[1:4])
iris[1:4]
# 0~1 사이의 값으로 변화
min_max_norm <- function(x){
  (x - min(x)) / (max(x) - min(x))
}
# 열을 대상으로 하는 lapply
class(lapply(iris[1:4], min_max_norm))
iris_norm <- as.data.frame(lapply(iris[1:4], min_max_norm))
head(iris_norm)
iris_norm$Species <- iris$Species
head(iris_norm)

install.packages("plyr")
library(plyr)
.libPaths()
data(iris)
str(iris)
