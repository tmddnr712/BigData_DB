# 시계열 분석의 평활법
vts <- c(1325, 1353, 1305, 1275, 1210, 1195)
mean(vts) # 단순이동평균법
mean(vts[1:5]) * .4 + vts[6] * .6 # 가중 이동평균법
mean(vts[1:5]) * .3 + mean(vts[6]) * .7
mean(vts[1:3]) * .2 + mean(vts[6]) * .8
((vts[4] * 4) + (vts[3] *3) + (vts[2] *2) + (vts[1] *1) / (4+3+2+1))

install.packages("TTR")
library(TTR)
data(ttrc)
class(ttrc)
str(ttrc) # OHLC(open, high, low, close <개장가, 고가, 저가, 종가>)
sma.20 <- SMA(ttrc[,"Close"], 20) # simple moving average
ema.20 <- EMA(ttrc[,"Close"], 20) # exponential moving average
wma.20 <- WMA(ttrc[,"Close"], 20) # weighted moving average
class(sma.20)
sma.20
ema.20
wma.20
par(mfrow = c(1,1))
plot(ttrc$Open)
plot(sma.20)
plot(ema.20)
plot(wma.20)

a <- ts(1:20, frequency = 12, start = c(2011,3))
print(a)
str(a)
attributes(a)

kings <- scan("C:/Users/노승욱/Desktop/R자료/kings.dat")
class(kings)
kingstimeseries <- ts(kings)
kingstimeseries
plot.ts(kingstimeseries)

# 뉴욕 월별 출생일 수
births <- scan("C:/Users/노승욱/Desktop/R자료/births.dat")
birthstimeseries <- ts(births, frequency = 12, start=c(2008,1))
birthstimeseries
plot.ts(birthstimeseries)

# fancy.dat 파일을 읽어서 1987.1 월부터 배치
fancys <- scan("C:/Users/노승욱/Desktop/R자료/fancy.dat")
fancystimeseries <- ts(fancys, frequency = 12, start=c(1987,1))
fancystimeseries
plot.ts(fancystimeseries)

##########
plot.ts(kingstimeseries)
kingsSMA3 <- SMA(kingstimeseries, n=3)
plot.ts(kingsSMA3)

plot.ts(kingstimeseries)
kingsSMA8 <- SMA(kingstimeseries, n=8)
plot.ts(kingsSMA8)

install.packages("tseries")
library(tseries)
kpss.test(kingsSMA8)


# WWWusage의 데이터 중에 60기 까지만 데이터를 분석하고 향후 10기에 대하여 예측
install.packages("forecast")
library(forecast)
library(tseries)
library(TTR)
library(ggplot2)
class(WWWusage)
head(WWWusage)
plot(WWWusage) # 매 분당 인터넷에 연결된 유저수를 관측해놓은 데이터

log(WWWusage) %>%
  Arima(order=c(1,1,1)) %>%
  forecast(h=20) %>%
  autoplot

kpss.test(WWWusage)
acf(WWWusage)
pacf(WWWusage)

kpss.test(log(WWWusage)) #안정적적
acf(log(WWWusage))
pacf(log(WWWusage))
auto.arima(log(WWWusage))
?Arima
#lambda parameter : Box-Cox transformation
WWW.model <- Arima(log(WWWusage), order=c(1,1,1), seasonal = list(order=c(1,1,1),
                                                                   period=12), lambda = 0)
plot(forecast(WWW.model))
model <- Arima(window(log(WWWusage), end=60), order = c(1,1,1),
               seasonal = list(order = c(1,1,1),period=12),lambda=0)
plot(forecast(WWW.model, h=10))
accuracy(WWW.model)

# 지수 평활모델을 이용한 예측
fit <- ets(WWWusage)
plot(WWWusage)
lines(fitted(fit), col='red')
lines(fitted(fit, h=2), col='green')
lines(fitted(fit, h=3), col="blue")
legend("topleft", legend=paste("h=", 1:3), col=2:4, lty=1)


# 문제: 오스트레일리아 가스 생산량 예측
data(gas)
plot(gas)
gas
kpss.test(gas) # kpss 안정성 테스트, 0.01로 비 안정성데이터
acf(gas)
gas.diff <- diff(log(gas))
gas.diff
adf.test(gas.diff, alternative = "stationary", k=0) # 안정성있는 데이터
kpss.test(gas.diff)
acf(gas.diff)
pacf(gas.diff)

auto.arima(gas.diff) # ARIMA(0,0,1)(0,1,1)[12]
gas.ari<-auto.arima(gas.diff)
summary(gas.ari)
# Box test : 귀무가설 : 피팅이 잘되어 있다. 대립가설: 피팅이 잘 안되어 있따.
tsdiag(gas.ari) #diagnostic 진단
# window time 데이터에 대하여 기간으로 subset 데이터를 생성
# 기간을 주어서 subset으로 모델을 생성
fit <- arima(window(log(gas), end=1980), c(0,0,1),
             seasonal = list(order=c(0,0,1), period=12))
forres <- forecast(fit, h=100)
names(forres)
forres$method # 80 95 interval : 신뢰구간
forres$fitted
forres$series
plot(forecast(fit, h=100))
plot(2.718^forres$fitted) # 피팅된(예측된) 데이터에 대한 그래프

fit <- arima(log(gas), c(1,0,1), seasonal = list(order=c(0,1,1),period=12))
plot(forecast(fit, h=100))
tsdiag(fit)
