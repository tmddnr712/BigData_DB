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
