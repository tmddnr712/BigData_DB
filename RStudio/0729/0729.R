install.packages("data.table")
library(data.table)
titanic <- read.csv("C:/Users/노승욱/DB/RStudio/0729/titanic3.csv", fileEncoding="UTF-8")
class(titanic)
titanic.dt <- data.table(titanic)
class(titanic.dt)
str(titanic.dt)
head(titanic.dt)
setkey(titanic.dt$pclass)
tables()
titanic.dt[pclass==1,]
titanic.dt[pclass==2]
class(titanic.dt[pclass==2])
# 인덱싱을 이용해서 데이터 처리 가능
titanic.dt[, mean(survived), by='pclass'] #grouping
titanic.dt[, length(which(pclass=='1'))]
titanic.dt[pclass=="1", .N]
titanic.dt[,mean(survived), by=sex]
titanic.dt[pclass=="1", mean(survived), by="sex"]
titanic.dt[pclass=="1", .N, by="sex"]

# 문제: 1등급 승객 중 성별 20세 이상인 성인 비율
titanic.dt[pclass=="1", length(which(age>20))/.N, by="sex"]

# 정리 문제
# 아래의 data.frame이 완성 될 수 있게 4, 5번을 완성하시오.
# empno   pay   bounus
# 101     250   0.10
# 102     180   0.10
# 103     200   0.12
# 104     300   0.15
# 105    1000   0.00

# 1) 위의 데이터 생성을 위해서 empno, pay, bounus 변수를 생성하시요
# 2) 위의 표의 형식대로 데이터프레임을 생성하세요.
# pay201801 <-

# 3) 다음의 출력처럼 total 컬럼을 추가하려고한다. 아래의 순번에 내용을 작성하세요.
  # 1) 계산 : total <-
  # 2) 함수: pa201801 <-               (pay201801, total)

# 4) dplyr 패키지의 관련함수를 이용해서 총급여 300이상인 사원번호와 총급여를 출력하세요.

# 5) 다음 출력처럼 부서번호(deptno)을 추가하세요.
# empno   pay   bounus  deptno
# 101     250   0.10      1
# 102     180   0.10      2
# 103     200   0.12      1
# 104     300   0.15      2
# 105    1000   0.00      2

# 아래의 출력 내용처럼 부서별 급여 평균을 출력하세요
# A tibble : 2 x 2
# deptno          mean_total
# <dbl>           <dbl>
#   1       1     250.
#   2       2     514.