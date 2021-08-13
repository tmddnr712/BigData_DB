# Perceptron의 구현
x1 <- runif(30, -1, 1) # 균등 분포
x2 <- runif(30, -1, 1)
x <- cbind(x1, x2)
Y <- ifelse(x2 > 0.5 + x1, +1, -1) # y 값을 결정

plot(x, pch=ifelse(Y>0,"+","-"), xlim=c(-1,1), ylim=c(-1,1), cex=2)
abline(0.5, 1)

calculate_distance = function(x,w,b){ # forward propagation 순전파
  sum(x*w) + b
}

linear_classifier = function(x, w, b){
  distances = apply(x, 1, calculate_distance, w, b) # 현재의 가중치와 바이어스
  return(ifelse(distances < 0, -1, +1)) # 분류
}

second_norm = function(x) {sqrt(sum(x * x))} # 정규화
# 학습률은 오차에 적용될 학습 정도 : learning_ rate: 큰경우 - 학습속도가 빨라짐, 작은 경우: 데이
perceptron = function(x, y, learning_rate = 1){ # 가중치와 바이어스를 학습하는 경우
  w = vector(length = ncol(x)) # 가중치
  b = 0 # 바이어스
  k = 0 # log 출력 횟수 조절
  R = max(apply(x, 1, second_norm)) # 방향값 중 가장 큰 값을 R값으로 결정정
  incorrect = TRUE
  plot(x, cex = 0.2)
  while(incorrect){ #무한 루프
    incorrect = FALSE # 밑에서 incorrect 값이 변화하지 않으면 종료
    yc <- linear_classifier(x,w,b) # 예측값(순전파)
    for(i in 1:nrow(x)){ # 30
      if(y[i] != yc[i]){ # 실제값과 예측값을 비교
        w <- w + learning_rate * y[i] * x[i,] #역전파(가중치를 수정)
        b <- b + learning_rate * y[i] * R^2
        k <- k+1
        if(k%%5 == 0){
          intercept <- - b / w[[2]]
          slope <- - w[[1]] / w[[2]]
          abline(intercept, slope, col="red")
          cat("반복 # ", k, "\n")
          cat("계속하기 위해 [enter]")
          line <- readline() # 잠깐 중지
        }
        incorrect = TRUE # y값이 예측값과 실제값이 같지 않으면 끝내지 말기
      }
    }
  }
  s = second_norm(w) # 방향 값을 결정
  return(list(w=w/s, b=b/s, updates=k)) # s 정규화 된 값
}
(p <- perceptron(x, Y))
(y <- linear_classifier(x, p$w, p$b))
plot(x, cex=0.2)
points(subset(x, Y==1), col = "black", pch="+", cex=2)
points(subset(x, Y==-1), col = "red", pch="-", cex=2)
intercept <- - p$b / p$w[[2]]
slope <- - p$w[[1]] / p$w[[2]]
abline(intercept, slope, col="green")

