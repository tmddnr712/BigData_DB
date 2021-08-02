data(cars)
str(cars)
head(cars)
plot(cars$speed, type="l")
plot(cars$dist, type="l")
plot(cars, type="l")
plot(cars, type="p")
plot(cars, type="b")
plot(cars, type="b", pch=20)
plot(cars, type="b", pch=22)
plot(cars, type="b", pch="+")
plot(cars, type="b", pch=2, cex=2)
plot(cars, type="l", pch="+", cex=2, col="red", lty="dotdash")
plot(cars$dist, main="속도와 제동거리", sub="단위:miles", type="b", pch="+", cex=1, ylab="distance",
    lty="dotdash", ylim=c(10,40), xlim=c(10,20), asp=1.0)
?plot

plot(cars, cex=0.5)
identify(cars$speed, cars$dist)

# 코인 앞면을 4번 던지고 앞면이 몇번 출력했는가를 관측한 데이터
coin <- c(2, 2, 0, 1, 1, 1, 2, 3, 1, 2, 2, 3, 3, 4, 1, 3, 2, 3, 3, 1, 2, 2, 1, 2, 2)
(frequency <- table(coin)) # 도수 분포표
(relative <- frequency/length(coin)) # 상대 도수분포표
cumulative <- cumsum(relative) # 누적분포표
opar <- par(mfrow = c(1, 4)) # parameters = mfrow
plot(frequency, xlab="값", ylab="도수", type="b", col="red", main="도수",
     sub="순수도수", frame.plot=F)
plot(1:5, frequency, xlab="값", ylab="도수", type="b", col="red", frame.plot=F)
plot(round(relative,2),type="b",pch=23, col="red")
plot(round(cumulative,2), type="b", col="red", axex=F)
par(opar)
plot(round(cumulative,2), type="b", col="red", axex=F)
par(mrow=c(1,1))
plot(round(cumulative,2), type="b", col="red", axex=F)
opar<-par(mfrow=c(1,3))
# vertical, horizontal
barplot(frequency, xlab="값", ylab="도수", col="blue", border=TRUE, density=TRUE, horiz=TRUE, main="도수분포표")
barplot(round(relative,2),xlab="값", ylab="도수", col="red", main="상대도수분포표")
barplot(round(cumulative,2),xlab="값", ylab="도수", col="red", main="누적적상대도수분포표")
par(opar)


# xtab을 이용해서 생성한 경우 "table"
Titanic
class(Titanic)
margin.table(Titanic, 1)
margin.table(Titanic, 2)
margin.table(Titanic, 3)
margin.table(Titanic, 4)

barplot(margin.table(Titanic,1))
barplot(margin.table(Titanic,2))
barplot(margin.table(Titanic,3))
barplot(margin.table(Titanic,4))

# 4가지 경우를 테이블 생성
(titanic.data = xtabs(Freq ~Survived + Sex, data=Titanic))
class(titanic.data)

# rug 
hist(iris$Sepal.Width, freq=FALSE)
lines(density(iris$Sepal.Width))
rug(iris$Sepal.Width)
rug(iris$Sepal.Width, side=3, lwd=3)
rug(jitter(iris$Sepal.Width))

# boxplot
ret <- boxplot(iris$Sepal.Width)
ret
(c <- seq(0:100))
(d <- sort(round(runif(100)*100)))
quantile(c,0.25) # 1사분위수
quantile(d,0.25)
quantile(d,0.75) # 3사분위수
(sum(d)/100*4)
range(d)/4

fivenum(iris$Sepal.Width) # 사분위수를 결정 하한값, 1사분위수, 중위수, 3사분위수, 상한값
range(iris$Sepal.Width) # 하한값과 상한값
diff(range(iris$Sepal.Width)) # 범위값

# 문제 fivenum을 이용해서 IQR값을 구하시오(iris$Sepal.width에 대하여)
IQR(iris$Sepal.Width)
fivenum(iris$Sepal.Width)[4] - fivenum(iris$Sepal.Width)[2]

#데이터가 버전에 따라 다른 데이터가 들어감
str(airquality)
boxplot(airquality$ozone)
ret <- boxplot(airquality$ozone,
               main="평균 오존량",
               xlab="Billion당",
               ylab="Ozone",
               col="orange",
               border="brwon",
               horizontal =TRUE,
               notch=TRUE)

str(InsectSprays)
png(file="sv1.png", width=600, height=350, res=100)
boxplot(count ~ spray, data = InsectSprays, col = "lightgray")
dev.off()
#lattice
library(lattice)
str(airquality)
xyplot(ozone ~ wind, data=airquality)
xyplot(ozone ~ wind | month, data=airquality)

install.packages("ggplot2")
library(ggplot2)
coin<- c(2,2,0,1,1,1,2,2,3,4,1,3,2,3,3,1,2,2,1,2,2)

coin.num = sort(unique(coin))
coin.freq = rep(0, length(coin.num)) #repeat
for(i in 1:length(coin.num)) { #인덱스는 1부터 내용은 0부터 시작 
  coin.freq[i] <- length(coin[coin==i-1])
}
coin.rel = round(coin.freq/length(coin), 2) #상대도수 분포표
coin.cum = cumsum(coin.rel) #누적 상대 도수 분포표

coin.freq <- data.frame(coin.num, coin.freq)
names(coin.freq)[2] <- paste("val")
coin.freq$type=rep("freq", length(coin.num))
coin.freq

coin.rel = data.frame(coin.num, coin.rel)
names(coin.rel)[2] <- paste("val")
coin.rel$type=rep("rel", length(coin.num))
coin.rel

coin.cum = data.frame(coin.num, coin.cum)
names(coin.cum)[2] <- paste("val")
coin.cum$type = rep("cum", length(coin.num))
coin.cum 


#------------------------------------------------------#
install.packages("dplyr")
library(dplyr)
install.packages("data.table")
library(data.table)
election <- read.csv("C:/Users/노승욱/DB/RStudio/0730/election_2012.csv", fileEncoding="UTF-8")
class(election)
election.dt <- data.table(election)
class(election.dt)
str(election.dt)
head(election.dt)

# 문제1
election.dt = election.dt %>% select(cand_id, cand_nm, contbr_nm, contbr_occupation, contb_receipt_amt)

# 문제2
romney <- subset(election.dt, cand_nm=="Bachmann, Michelle")
head(romney)
obama <- subset(election.dt, cand_nm == "Obama, Barack")
head(obama)

test1 <- subset(election.dt, contb_receipt_amt==250)
head(test1)

#문제3
romney_6000over <- subset(election.dt, contbr_nm=="Bachmann, Michelle" & contb_receipt_amt > 600)
head(romney_6000over)
obama_6000over <- subset(election.dt, contbr_nm=="Obama, Barack" & contb_receipt_amt > 600)
head(obama_6000over)

test1 <- subset(election.dt, contb_receipt_amt>250)
head(test1)

# 중복값제거
#election.dt %>% duplicated()
#duplicates <- election.dt %>% duplicated() %>% table()
#election.dt %>% distinct()
#election.dt %>% distinct(cand_id, .keep_all=TRUE)
#

library(dplyr)
election <- read.csv("C:/Users/yoobi/Downloads/election_2012.csv")
View(election)

# 문제 1
sample <- data.frame(election$cand_id,election$cand_nm,election$contbr_nm,election$contbr_occupation,election$contb_receipt_amt)

#문제2
romney<- subset(sample, sample$election.cand_nm=="Romney, Mitt")
head(romney)
obama<- subset(sample, sample$election.cand_nm=="Obama, Barack")
head(obama)


#문제 3
romney_6000over <- subset(romney, romney$election.contb_receipt_amt>= 600)
obama_6000over <- subset(obama, obama$election.contb_receipt_amt>=600)


#문제 4
romney2 <- subset(romney, romney$election.contbr_occupation != "" & 
                        +                       romney$election.contbr_occupation != "-")
obama2 <- subset(obama, obama$election.contbr_occupation != "" &
                     +                      obama$election.contbr_occupation != "-")

write.csv(romney2,"romney.csv",row.names = F)
write.csv(obama2,"obama.csv", row.names = F)

#문제 5
romney3 <- read.csv("C:/Users/yoobi/Documents/romney.csv")
obama3 <- read.csv("C:/Users/yoobi/Documents/obama.csv")
romney3_temp <- subset(romney3, romney3$election.contbr_occupation=="RETIRED") 
obama3_temp <- subset(obama3, obama3$election.contbr_occupation == "RETIRED")
sum(romney3_temp$election.contb_receipt_amt)
sum(obama3_temp$election.contb_receipt_amt)


# 문제 6
romney3_top3 <- romney3[order(-romney3$election.contb_receipt_amt),4:5] # 기본은 오름차순 -붙이면 내림차순됨
head(romney3_top3,n=3)

obama3_top3 <- obama3[order(-obama3$election.contb_receipt_amt),4:5]
head(obama3_top3,n=3)
