# boolean, integer => numeric
(x<-c(TRUE, FALSE, 0, 6)) #vector, ()안에 넣으면 즉시실행모드
(y<-c(FALSE, TRUE, FALSE, TRUE))
x
class(x)
typeof(x)

!x
x&y
x|y

v <- 2:8
print(v)
v1 <- 8
v2 <- 12
t <- 1:10
v1 %in% t
v2 %in% t

# row(행), column(열)
(M = matrix(c(2,6,5,1,10,4), nrow=2, ncol=3, byrow=TRUE))
# M = 2x3 행렬, t(tranverse 전치행렬) = 3x2(행과 렬변환)
t = M %*% t(M)
print(t)

#초기화는 반드시시
num <- 6
num <- num ^2 * 5 + 10/3
num

x1 = c(1, 3, 5, 7, 9, 10) #recycling
y1=  c(4, 5)
result = x1 * y1

# 기본적으로 함수의 매개변수는 벡터(자바:배열을전달)
exp(10)
exp(2:10)
sqrt(c(1,4,9,16))
sum(1:10000)
cos(c(0, pi/4)) # x축을 표현

1 / 0 # Inf 무한대
0 / 0 # NaN not a number
Inf / NaN
Inf / Inf
log(Inf)
Inf + NA # 결측치: 결측치와 연산을 하면 결과도 결측치가 됨

vec <- c(0, Inf, NaN, Na)
is.finite(vec)
is.nan(vec)
is.na(vec)
is.infinite(vec)
sum(vec)


getwd() #주소파악악

LETTERS
letters
month.name
month.abb
pi

#통계용어
score <- c(85, 95, 75, 65)
score
mean(score) # 평균
sum(score) # 합계
sum(score) / 4
var(score) # 분산 variance
sd(score) # 표준편차 standard deviation
score - 80
sum(score-80)
sum((score-80)^2)#25, 225, 25, 225
