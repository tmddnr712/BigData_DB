install.packages("arules")
library(arules)
a_matrix <- matrix(c(
  1,1,1,0,0,
  1,1,0,0,0,
  1,1,0,1,0,
  0,0,1,0,1,
  1,1,0,1,1
), ncol = 5)
dimnames(a_matrix) <- list(c("a","b","c","d","e"),
                           paste("Tr", c(1:5), sep = ""))
a_matrix
#
trans2 <- as(a_matrix, "transactions")
trans2
inspect(trans2)

tran <- read.transactions("C:/Users/노승욱/Desktop/R자료/tran.txt", format="basket",sep = ",")
tran
inspect(tran)
# support 지지도 , confidence 신뢰도 
rule <- apriori(tran, parameter = list(supp=0.3, conf=0.1)) # 16건
rule
inspect(rule)

rule <- apriori(tran, parameter = list(supp=0.1, conf=0.1)) # 35건
rule
inspect(rule)

rule <- apriori(tran, parameter = list(supp=0.1, conf=0.8, maxlen=10))
?apriori

data("Groceries")
str(Groceries) # 행: 거래, 열: 식품
Groceries # class 4형식
summary(Groceries)
inspect(head(Groceries, 3))
size(head(Groceries))
LIST(head(Groceries, 3))
itemFrequencyPlot(Groceries, topN = 15, type = "absolute")
gdf <- as(Groceries, 'data.frame')
head(gdf)
# 아이템 사이즈가 4보다 큰 경우를 출력
inspect(subset(Groceries[1:200], size(Groceries[1:200])>7))
itemFrequency(Groceries[, 1:10])

wholemilk_rules <- apriori(data=Groceries, parameter=list(supp=0.001, conf=0.008),
                           appearance = list(rhs="whole milk"))
inspect(wholemilk_rules)

arules <- apriori(Groceries, parameter = list(support=0.01,confidence=0.08, minlen=1)) # 472
inspect(arules)
rules <- apriori(Groceries, parameter = list(support=0.001,confidence=0.5))
rules_conf <- sort(rules, by="confidence", decreasing = TRUE)
inspect(head(rules_conf))
butter <- subset(arules, lhs %in% 'butter')
butter
inspect(butter)
install.packages("arulesViz")
library(arulesViz)
plot(arules, method="graph", control=list(type="items"))
plot(arules[1:5])
plot(arules[1:5], method = "graph", engine='interactive')
plot(arules[1:15], method="graph", engine='interactive')

subrules2 <- head(sort(arules, by = "lift"), 10)
inspect(subrules2)


wmilk <- subset(rules, rhs %in% 'whole milk')
wmilk
inspect(wmilk)
plot(wmilk, method="graph")

# 문제:
# filtering 기능: 규칙을 패턴을 확인 : 지지도가 약하거나 신뢰도가 약한 것으로 패턴을 판단하면 거짓말이 
# 최소 support = 0.5, 최소 confidence=0.8을 지정하여 연관규칙을 생성해 보시요
# 연관 분석 결과를 연관 네트워크 형태로 시각화 하시요
# lhs가 white인 규칙만 subset으로 작성하고 연관어를 시각화 하시요.
# lhs가 백인이거나 미국인을 대상으로 subset을 작성하고 연관어를 시각화 하시요
# rhs가 husband인 단어를 포함한 규칙을 subset으로 작성하고 연관어를 시각화 하시요.
# 결과물 support, confidence를 기준으로 내림차순으로 정렬한 다음 상위 3개만 출력하시요.
data("Adult")
summary(Adult)
str(Adult)
adult <- as(Adult, "data.frame")
head(adult)
class(adult)
class(Adult)

ar <- apriori(Adult, parameter = list(supp=0.1, conf=0.8)) # 6137 rule
ar1 <- apriori(Adult, parameter = list(supp=0.2, conf=0.8)) # 1306 rule
ar2 <- apriori(Adult, parameter = list(supp=0.2, conf=0.95)) # 348 rule
ar3 <- apriori(Adult, parameter = list(supp=0.3, conf=0.95)) # 124 rule
ar4 <- apriori(Adult, parameter = list(supp=0.4, conf=0.80)) # 169 rule

is <- apriori(Adult, parameter = list(support=0.01, target="rules"), appearance = list(lhs=c("income=small", "income=large")))
items(is)
itemFrequency(items(is))["income=small"]
itemFrequency(items(is))["income=large"]

rules <- apriori(Adult, parameter=list(support=0.5, confidence=0.8, target="rules"))
plot(rules, method = "graph", engine="interactive")
plot(rules) # 산포도
plot(rules, method = "grouped")
itemFrequencyPlot(Adult, support=0.5)

# lhs = white
white.lhs <- subset(rules, lhs %in% "race=White")
inspect(white.lhs) # 24건건
plot(white.lhs, method="graph")
plot(white.lhs, method="grouped")
plot(white.lhs, method="graph", control = list(layout=igraph::in_circle(), nodeCol=grey.colors(10),
                                               edgeCol=grey(.7), alpha=1))

# 백인 or 미국인
whiteORus.lhs <- subset(rules, lhs %in% "race=White", lhs %in% "native-contry=United States")
whiteORus.lhs
inspect(whiteORus.lhs)
plot(whiteORus.lhs, "graph")

# set of 0 rules
rules <- apriori(Adult, parameter = list(support=0.3, confidence=0.5))
husband.rhs <- subset(rules, rhs %in% "relationship=Husband")
husband.rhs
inspect(husband.rhs)
plot(husband.rhs, method="grouped")

# 정렬
inspect(head(sort(rules, decreasing = T, by =c("support", "confidence")),3))

#
data("AdultUCI")
str(AdultUCI)
