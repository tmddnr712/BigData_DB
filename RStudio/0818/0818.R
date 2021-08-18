# 평점 행렬 
install.packages("recommenderlab") #추천시스템 
library(recommenderlab)
m <- matrix(sample(c(NA,0:5),100, replace = TRUE, prob = c(.7,rep(.3/6,6))),
            nrow=10, ncol=10, dimnames=list(
              user=paste('u',1:10, sep = ''),
              item=paste('i',1:10, sep = '')
            ))
m  # 희소행렬 sparce matrix -> matrix factorization 
dim(m)
r<- as(m, "realRatingMatrix")
r
class(r)
dim(r)
dimnames(r)
rowCounts(r)
colCounts(r)
rowMeans(r)
getRatings(r)
getRatingMatrix(r)
image(r)
nratings(r)
hist(getRatings(r))
as(r, "list")
head(as(r,"data.frame"))
# 이진행렬 이름으로 구분하는 것이 아니라 순서에 의해서 처음 열 user 행 item
df <- data.frame(user=c(1,1,2,2,2,3), item=c(1,4,1,2,3,5))
df
b2 <- as(df,"binaryRatingMatrix")  #행 :user  열 : items 
b2
as(b2,"matrix")


movie <- read.csv("C:/Users/user/R/movie.csv", header = T)
movie
str(movie)
# user a가 movie4,5 영화를 보지않음 -> movie4,5번중 추천 받기 

moview_t <- t(movie[, -c(1,5,6)]) #전치 시킨 이유 : 사용자별로 유사도를 재기 위해 
# cor 상관계수는 열별로 상관을 계산함 
moview_t
class(moview_t)
colnames(moview_t) <- c("a","b","c","d","e")
moview_t
cor(moview_t)
# c와 d가 a 유저와 가장 유사한 구조 -> movie5를 추천  


#
recomm_w <- read.csv('C:/Users/user/R/sf_recomm.csv')
dim(recomm_w)
head(recomm_w)
recomm_df <- recomm_w[c(1:8)]
head(recomm_df)
# 나와 비슷한 패턴을 보이는 사람의 연금 상품을 추천 
# 추천 받을 사람의 데이터 
inputdata <-c(0,208,55,60,35,0,25,183)
# data.frame 생성 
recomm_df2 <- rbind(inputdata,recomm_df)
head(recomm_df2)
# 유사도 계산을 위한 데이터 변형
recomm_data <- recomm_df2[2:8]
recomm_data
str(recomm_data)

# 유클리디안 거리값 계산 > 대상자를 6명으로 제한해서 거리값을 구함 
test_dist <- dist(head(recomm_data), method="euclidean")
test_dist

# matrix로 구조 변경
test_dist_mt <-as.matrix(test_dist)
test_dist_mt[,1]
# 거리 계산값을 정렬  >  순서를 정렬한 다음 
test_dist_mt_sort <- sort(test_dist_mt[,1])
test_dist_mt_sort
# 두번째 label반환 > 자기자신을 제외한 2번째 있는 데이터를 선택
result_index <-names(test_dist_mt_sort[2])
real_index <-as.numeric(result_index)
real_index

#추천 데이터셀에서 5번재 관측치 code 추출  (추천된 사람의 내용 비교 )
recomm_df2[real_index,1]
recomm_df2[real_index, ]
recomm_w[real_index, 9:13]
#추천 상품 : 14480743 인 사람의 연금상품  

# 모델을 이용한 추천 Recommand 
library(reshape2)
movie <- read.csv(file.choose(), header = T)
movie

# 거래데이터 -> 평점행렬
movie_long <- melt(id=1, movie)
movie_long

names(movie_long) <- c("user","movie","rating")
movie_long

movie_long <-subset(movie_long, rating!=0)
movie_long
length(movie_long$rating)
moview_real <-as(movie_long,"realRatingMatrix")
dim(moview_real)
as(moview_real,"matrix")

# a에 대하여 추천 
trainset <- moview_real[c(2:5),]
as(trainset, "matrix")

recommTaget <- moview_real[1,]
# 행간 유사도 : Pearson 상관계수를 이용한 유사도를 사용 방향을 중시 
recomm_model <- Recommender(trainset,method="UBCF", parameter="Pearson")
recomm_model
# 훈련에 참여한 데이터와 추천대상자와 유사도 구해서 비어있는 것에 대하여 유사성을 추천 
recomm_list <-predict(recomm_model, recommTaget, n=3)
recomm_list # topList 
recomm_result <- as(recomm_list, "list")
recomm_result
as(recomm_list,'matrix')


# 음식주문 패턴에 따른 음식 추천받기 
# 3가지 이상 음식을 주문한 사람만 학습자로 하고 학습에 참여 못한 사람에 대하여 음식을 추천
gloseri <- read.csv(file.choose(), header = T)
head(gloseri)
str(gloseri)

realData <- as(gloseri, 'realRatingMatrix')
as(realData,'matrix')
rowCounts(realData)
colCounts(realData)
rowMeans(realData)
getRatingMatrix(realData)
getRatings(realData)
image(realData)
nratings(realData)

trainData <-sample(1:7,6)
trainSet <- realData[trainData]
trainSet
as(trainSet,'matrix')

trainSet2 <- trainSet[rowCounts(trainSet)>=3]
as(trainSet2,'matrix')

recomm_model_gl <-Recommender(trainSet2, method="UBCF", parameter="Cosine")
recomm_model_gl

recomm_target_gl <- realData[-trainData]
as(recomm_target_gl, 'matrix')

recommadList <- predict(recomm_model_gl, recomm_target_gl, n=2)
recomm_result <- as(recommadList, 'list')
recomm_result
####### IBCF 기반 추천 시스템 


realData <- as(gloseri, 'realRatingMatrix')
as(realData,'Matrix')
realData_b <- binarize(realData,minRating=1)

trainData <-sample(1:7,6)
trainSet <-realData_b[trainData]
trainSet
as(trainSet, 'matrix')

recomm_target_gl<- realData_b[-trainData]
recomm_target_gl
as(trainSet, 'matrix')
# 열간의 척도를 적용 
recomm_model_gl <- Recommender(trainSet, method='IBCF', parameter='Jaccard')
recomm_model_gl

recommandList <- predict(recomm_model_gl, recomm_target_gl, n=2)
class(recommandList) 
recomm_result <-as(recommadList, 'list')
recomm_result

####################
data("MovieLense")
MovieLense # 948명 x 1664개의 영화화
head(as(MovieLense, "matrix")[, c(1:5)])
str(MovieLense)
MovieLense@data # c: compressor
getRatingMatrix(MovieLense)

print(rowCounts(MovieLense)) # 사용자 별로 영화를 본 횟수
colCounts(MovieLense) # 영화별로 영화를 본 사용자가 몇명인가.

table(rowCounts(MovieLense)>=50) # 565명
table(colCounts(MovieLense)>=50) # 601개의 영화

image(MovieLense[1:100, 1:100])
rating_movies <- MovieLense[rowCounts(MovieLense)>=50, colCounts(MovieLense)>=100]
rating_movies

idx <- sample(1:nrow(rating_movies), nrow(rating_movies)*0.9)
idx
trainSet <- rating_movies[idx,]
recomm_target <- rating_movies[-idx,]
dim(trainSet) # 508 336
dim(recomm_target) # 57 336

recomm_model <- Recommender(trainSet, method="UBCF", parameter="Cosine")
recomm_list <- predict(recomm_model, recomm_target, n=5)
recomm_list

as(recomm_list, "list")
length(as(recomm_list, "list"))

head(as(recomm_list, "matrix"))
rec_list <- as(recomm_list, "list")
rec_df <- as.data.frame(rec_list)
rec_df
# 사용자가 열로 출력
result_df <- t(rec_df)
result_df
head(result_df)

colnames(result_df) <- c('추천1', '추천2', '추천3', '추천4', '추천5')
str(result_df)
head(result_df)

write.csv(result_df, "recommends_movie.csv", row.names=T)

################################
movie