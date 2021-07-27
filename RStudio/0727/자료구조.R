#vector : 1차원 배열 +선형대수

x<- c(3,2,6,4,5,8,1)
x
sort(x)  # 정렬 
sort(x, decreasing = TRUE)

order(x) #순서: 이름   국어 
order(x, decreasing = TRUE)
x[order(x)]


sum(2,7,5)
x =c(2,NA, 3,1,4)
sum(x)  #결측치 처리 
sum(x,na.rm=TRUE)
mean(x, na.rm=TRUE)
median(x, na.rm=TRUE) # 중위수-중시:이상치를 제거 가능


vectorA<- c(1,2,3,4)
(names(vectorA) <-c("국어","영어","수학","과학"))
vectorA["국어"]
vectorA[2]  
vectorA[-1]
vectorA[c(1,3)]
vectorA[vectorA>5]
#값에 의한 전달 : 주소를 전달하는데 불구하고 복사
append(vectorA, c(3,4,5))
vectorA  # 원본에는 무영향 
(vectorB = append(vectorA, c(3,4,5)))
vectorB

#집합연산
#합집합 교집합 차집합 

union(vectorA,vectorB)
intersect(vectorA,vectorB)
setdiff(vectorA,vectorB)
setdiff(vectorB,vectorA)
setequal(vectorA,vectorB)

#subset & which 

(x<- c(3,2,6,4,5,8,1))
subset (x, x>3)
which(x*x>8)  #인덱스 위치값 

(vectorA<-c(1,2,3))
(names(vectorA)<-c("aaa","bbb","ccc"))
# vectorA에서 2보다 큰 값만 
# vectorA에서 요소를 제곱했을 때 8보다 큰 위치값

subset(vectorA, vectorA>2)
which(vectorA*vectorA >8)

# 복원추출 F는 비복원
(x<- sample(1:10,3,replace = T)) 
(x<- sample(1:10,3,replace = F)) 


x=c(1,2,3)
y=c(4,5,6)
x%*%y

nums <-c(5,8,10,NA,3,11)
nums
which.min(nums)
which.max(nums)
nums[which.min(nums)]
nums[which.max(nums)]

# 1)vector1 변수를 만들고 "R" 문자가 5회 반복
(Vector1 <- rep("R", 5))

# 2)Vector2 변수에 1~20까지 3간격으로 연속된 정수 만들기
(Vector2 <- seq(1,20, by=3))

# 3)Vector3에 1~10까지 3간격으로 연속된 정수가 3회 반복
(Vector3 <- rep(seq(1,10, by=3), 3))

# 4)Vector4에 Vector2~3이 모두 포함되는 벡터 생성
(Vector4 <- append(Vector2, Vector3))

# 5) 25 ~ -15까지 5간격으로 벡터 생성 seq()이용
seq(25, -15, by = -5)

# 6) Vector4에서 홀수번째 값들만 선택하여 Vector에 할당 (첨자 이용)
(seq(1, length(Vector4), 2))
(Vector5 <- Vector4[seq(1, length(Vector4), 2)])

# 7) Vector5에서 짝수 번째 값들만 선택하여 Vector6에 할당(첨자 이용)
(seq(2, length(Vector5), 2))
(Vector6 <- Vector5[seq(2, length(Vector5), 2)])

# 8) Vector5의 데이터를 문자로 변경하시오(as.character())
Vector5
Vector7 = as.character(Vector5)
Vector7

# 9) Vector5와 Vector6을 벡터 연산하여 더하시오(as.numetric())
Vector5 + Vector6

# 9-1) Vector5와 Vector6을 벡터 연산하여 더하시오(as.numetric())
Vector5 + as.numeric(Vector7)


#install.packages("NISTunits", dependencies = TRUE)
#library(NISTunits)
x <- c(1,0,0)
y <- c(0,1,0)
xq = sqrt(1^2 + 0^2 + 0^2) #norm
yq = sqrt(0^2 + 1^2 + 0^2) #norm
x = x/xq
y = y/yq
angle = x %*% y # 크기값이 고려된 사이각
#NISTradianTOdeg(acos(angle))

# Factor
(x <- factor(c("single", "married", "married", "single")))

class(x)
levels(x)

(x <- factor(c("single", "married", "married", "single"),
              levels = c("single", "married", "divorced")))

str(x)
levels(x)

x[3]
x[c(2,4)]
x[-1]
x[2] = "divorced"
x

cbind(c(1,2,3), c(4,5,6)) # column
rbind(c(1,2,3), c(4,5,6)) # row

(x = matrix(1:9, nrow = 3, byrow=TRUE))
(y = matrix(11:19, nrow = 3, byrow=TRUE))
(c = cbind(x,y))
(r = rbind(x,y))
dim(x)

(x <- c(1,2,3,4,5,6))
dim(x)
(dim(x) <- c(2,3))
x

(x = matrix(1:9, nrow = 3, byrow=TRUE))
x[c(1,2),c(2,3)]
x[c(2,3),]
x[,]
(a=x[1,])

x[c(TRUE,FALSE,TRUE), c(TRUE,TRUE,FALSE)]
x[c(TRUE,FALSE),c(2,3)] #recycling
x[c(TRUE,FALSE)]

x[x>5]
x[x%%2 == 0]

(x[2,2] <- 10)
(x[x<5] <- 0)
x

# 2x + 3y = 5
# 3x + 5y = 6
mdat = matrix(c(2,3,3,5), nrow=2, byrow=T)
c = c(5,6)
solve(mdat, c)

# 문제: 다음 방정식의 해를 푸시오
# 2x + y + z = 1
# 4x + 3y + 4z = 2
# -4x + 2y + 2z = -6
mat3 = matrix(c(2,1,1, 4,3,4, -4,2,2), nrow=3, byrow=T)
c1 = c(1,2,-6)
solve(mat3, c1)

# 문제 1~15를 요소로하는 5x3 행렬을 만들고 16~30을 요소로 하는 5x3행렬을 만들고
# 1) 두 행렬을 rbind와 cbind로 묶어서 출력 하시요
# 2) 위 두 행렬의 사칙 연산을 수행하시요.
(mat1 = matrix(1:15, nrow = 5, ncol=3, byrow=T))
(mat2 = matrix(16:30, nrow=5, ncol=3, byrow=T))
str(mat1)
str(mat1[1,])
dim(mat1)
dim(mat2)
# 1) 두 행렬을 rbind와 cbind로 묶어서 출력 하시요
rbind(mat1,mat2)
cbind(mat1,mat2)
# 2) 위 두 행렬의 사칙 연산을 수행하시요.
(mat1 + mat2)
(mat1 - mat2)
(mat1 * mat2)
(mat1 / mat2)
# 3 두 행렬의 곱
(mat1 %*% t(mat2))


