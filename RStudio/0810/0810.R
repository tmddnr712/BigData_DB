install.packages("gbm")
install.packages("reshape2")
install.packages("randomForest")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("MASS")
library(dplyr)
library(gbm)
library(ggplot2)
library(reshape2)
library(randomForest)
library(MASS)
letter <- read.csv("C:/Users/노승욱/Desktop/R자료/letter_rec.csv", header = T)
str(letter)
# 프로젝트 제목 문자 인식
# A4용지
attach(letter)
letterBCDGOQ <- letter[Class == "B" | Class == "C" | Class == "D" | Class = "G"
                       Class == "O" | Class == "Q",]
write.csv(letterBCDGOQ, "letterBCDGOQ.csv")

