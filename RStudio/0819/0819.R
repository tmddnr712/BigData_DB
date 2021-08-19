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
