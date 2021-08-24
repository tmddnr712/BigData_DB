################################## packages
install.packages("caret")
install.packages("randomForest")
install.packages("class")
install.packages("tidyverse")
install.packages("dslabs")
install.packages("kableExtra")
install.packages("stringer")
install.packages("forcats")
install.packages("gam")
install.packages("splines")
install.packages("foreach")
install.packages("mgcv")
install.packages("nlme")
install.packages("data.table")
install.packages("funModeling")
install.packages("magrittr")
install.packages("DataExplorer")
install.packages("skimr")
install.packages("mice")
install.packages("VIM")
install.packages("GGally")
install.packages("MASS")
install.packages("glmnet")
install.packages("e1071")
install.packages("rpart")
install.packages("pROC")
install.packages("gbm")
install.packages("ROCR")

################################# library
library(caret) # short for Classification And Regression Training, major reference
library(randomForest)
library(class) # for K-Nearest Neighbors Classification
library(tidyverse)
library(dslabs)
library(kableExtra)
library(stringr)
library(forcats)
library(gam)
library(splines)
library(foreach)
library(mgcv)
library(nlme)
library(data.table)
library(funModeling)
library(magrittr)
library(DataExplorer) 
library(skimr)
library(mice)
library(VIM)
library(GGally)
library(MASS)
library(glmnet)
library(e1071)
library(rpart)
library(pROC)
library(gbm)
library(ROCR)

############################## DATA
Hearts_UCI<- read.csv ('C:/Users/³ë½Â¿í/DB/RStudio/knn_RF_HF/heart_failure_clinical_records_dataset.csv', fileEncoding = 'UTF-8-BOM', header=TRUE)
colnames (Hearts_UCI)

############################## Missing Variable Checking
Hearts <- Hearts_UCI
dplyr::glimpse(Hearts)
skimr::skim(Hearts)
anyNA(Hearts)
colSums(is.na(Hearts))
md.pattern(Hearts)

############################# Outcome VR - DEATH_EVENT
round(prop.table(table(Hearts$DEATH_EVENT)),2)

############################ Data Pre-Processing
# Hearts %<>% mutate_if(is.character, as.factor)

Hearts$anaemia=factor(Hearts$anaemia) # cp
levels(Hearts$anaemia)=c("Non Anaemia", "Anaemia")

Hearts$diabetes=factor(Hearts$diabetes) # fbs
levels(Hearts$diabetes)=c("Non diabetes", "diabetes")

Hearts$high_blood_pressure=factor(Hearts$high_blood_pressure)  # restecg
levels(Hearts$high_blood_pressure)=c("Below120", "Above120")

Hearts$smoking=factor(Hearts$smoking)
levels(Hearts$smoking)=c("No","Yes")

Hearts$sex=factor(Hearts$sex)
levels(Hearts$sex)=c("Female", "Male")

Hearts$DEATH_EVENT=factor(Hearts$DEATH_EVENT)
levels(Hearts$DEATH_EVENT)=c("Live","Death")

head(Hearts,3)

glimpse(Hearts)

Hearts<- Hearts

################################### Principal Component Analysis(PCA)
#en: entropy measured in bits mi: mutual information
#ig: information gain
#gr: gain ratio (is the most important metric here, ranged from 0 to 1, with higher being better)
#pca <- prcomp(as.data.frame(split$continuous), scale = TRUE)
# Error in colMeans(x, na.rm = TRUE) : 'x' must be numeric
#pca$rotation
 
#prop_varianza <- pca$sdev^2 / sum(pca$sdev^2)
#prop_varianza
#ggplot(data = data.frame(prop_varianza, pc = 1:6), 
#       aes(x = pc, y = prop_varianza)) + geom_col(width = 0.3) + scale_y_continuous(limits = c(0,1)) + theme_bw() + labs(x = "Componentent of principal", y = "Proportion of variable explained")

split <- split_columns(Hearts)
split[[3]]
split[[4]]
split[[5]]
print (split$num_discrete)
print (split$num_continuous)
print(split$num_all_missing)

#################################### DATA VISUALIZATION
install.packages("ggthemes")
library(ggthemes)
theme_set(ggthemes::theme_hc())

#1
ggplot(gather(Hearts[,sapply(Hearts, is.numeric)], cols, value), 
       aes(x = value, fill = cols)) + 
  geom_boxplot() + 
  facet_wrap(cols~., scales = "free") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        legend.position =  "none") 

#2
ggplot(gather(Hearts[,sapply(Hearts, is.numeric)], cols, value), 
       aes(x = value)) + 
  geom_histogram(aes(fill = cols)) + 
  geom_density(aes(y = stat(count))) +
  facet_wrap(cols~., scales = "free") +
  theme(legend.position =  "none",
        axis.title.y = element_text(angle = 90))

#3
install.packages("AppliedPredictiveModeling")
library(AppliedPredictiveModeling)
AppliedPredictiveModeling::transparentTheme(trans = .5)

featurePlot(x = split$continuous, 
            y = Hearts$DEATH_EVENT,
            plot = "density", 
            scales = list(x = list(relation = "free"), 
                          y = list(relation = "free")), 
            adjust = 1.5, 
            pch = "|", 
            layout = c(3, 2),
            auto.key = list(columns = 2))

#4
AppliedPredictiveModeling::transparentTheme(trans = 0.4)

featurePlot(x = split$continuous, 
            y = Hearts$DEATH_EVENT, 
            plot = "pairs",
            auto.key = list(columns = 2)) 


################################################# VISUALIZTION
table(Hearts$sex,Hearts$DEATH_EVENT)
table(Hearts$sex,Hearts$DEATH_EVENT)
par(mfrow=c(1,1))
col.DEATH_EVENT <- c("yellow","pink")
plot(table(Hearts$sex,Hearts$DEATH_EVENT),xlab="Gender",ylab="Diagnostics",col=col.DEATH_EVENT, main=" ")

summary(Hearts)

# sex
ggplot(Hearts, mapping = aes(x = DEATH_EVENT, fill = sex)) +
  geom_bar(position = "fill") +
  labs(
    title = "Heart Failure Prediction",
    subtitle = "Heart",
    
    caption = "heart failure") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

## anaemia
ggplot(Hearts, aes(x = DEATH_EVENT, fill = anaemia)) +
  geom_bar(position = "stack") +
  labs(
    title = "anaemia") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

## diabetes
ggplot(Hearts, aes(x = DEATH_EVENT, fill = diabetes)) +
  geom_bar(position = "stack") +
  labs(
    title = "diabetes") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

# high_blood_pressure
ggplot(Hearts, aes(x = DEATH_EVENT, fill = high_blood_pressure)) +
  geom_bar(position = "stack") +
  labs(
    title = "high_blood_pressure") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

# smoking
ggplot(Hearts, aes(x = DEATH_EVENT, fill = smoking)) +
  geom_bar(position = "stack") +
  labs(     title = "smoking") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

########################################### VARIABLE CORRELATION PLOT
install.packages("ggcorrplot")
library(ggcorrplot)

ggcorr(Hearts, label = T)

############################################# DATA PREPROCESSING
# converts disease2 as factor "0" or "1" to use with confusionMatrix()
Hearts <- mutate_at(Hearts, vars(DEATH_EVENT), as.factor) 
str(Hearts$DEATH_EVENT)

unique (Hearts$DEATH_EVENT)

## to Prevent the model from using positive case as "no heart disease"
# positive class is now correct: heart disease
Hearts$DEATH_EVENT <- relevel(Hearts$DEATH_EVENT, ref= 'Heart Disease')

############################################# Training / Testing Data Split
test_index <- createDataPartition(y = Hearts$DEATH_EVENT,
                                  times = 1, p = 0.2, list = FALSE) 
edx <- Hearts[-test_index,]  
validation <- Hearts[test_index,] # we will use it only to do final test

test_index <- createDataPartition(y = edx$DEATH_EVENT,
                                  times = 1, p = 0.2,
                                  list = FALSE)  # test_set 20%
train_set2 <- edx[-test_index,]
test_set2 <- edx[test_index,]
true_value_DEATH_EVENT2 <- test_set2$DEATH_EVENT 

control <- trainControl(method = "cv",   # cross validation
                        number = 10,     # 10 k-folds or number
)

########################################### MODELING(KNN)
fitControl <- trainControl(## 10-fold CV
  method = "repeatedcv",
  number = 10,
  repeats = 10,
  classProbs = TRUE,
  summaryFunction = multiClassSummary)

knncv <- train(DEATH_EVENT~., 
               data=edx,
               method = "knn", 
               trControl=control,
               metric ='Accuracy' )
print(knncv)

prediction_knncv <- predict (knncv,newdata=validation)
confusionMatrix(prediction_knncv, validation$DEATH_EVENT)

knncv_autogrid <- train(DEATH_EVENT~., 
                        data=edx,
                        method = "knn", 
                        trControl = control,
                        metric = 'Accuracy',
                        tuneLength = 30)

knncv_autogrid$results %>%
  arrange(desc(Accuracy)) %>%
  round(3)

colors <- c("Accuracy" = "red" )
knncv_autogrid$results %>%
  ggplot(aes(k)) +
  geom_line(aes(y = Accuracy, col = "Accuracy")) +
  geom_point(aes(y = Accuracy)) +
  labs(title = "K-NN with 10 repeated 10 fold Cross Validation, 1st Sample Split",
       subtitle = "Accuracy ",
       color = "Legend") +
  scale_color_manual(values = colors) +
  theme(legend.position = "top",
        axis.title.y = element_blank()) 

fitControl <- trainControl(## 10-fold CV
  method = "repeatedcv",
  number = 10,
  repeats = 10,
  classProbs = TRUE,
  summaryFunction = multiClassSummary)

knncv2 <- train(DEATH_EVENT~., 
                data=train_set2,
                # data=edx,
                method = "knn", 
                trControl=control,
                metric ='Accuracy' )
print(knncv)

knncv_autogrid2 <- train(DEATH_EVENT~., 
                         data=train_set2,
                         #     data=edx,
                         method = "knn", 
                         trControl = control,
                         metric = 'Accuracy',
                         tuneLength = 30)

knncv_autogrid2$results %>%
  arrange(desc(Accuracy)) %>%
  round(3)

colors <- c("Accuracy" = "blue" )
knncv_autogrid2$results %>%
  ggplot(aes(k)) +
  geom_line(aes(y = Accuracy, col = "Accuracy")) +
  geom_point(aes(y = Accuracy)) +
  labs(title = "2nd Sample Split, K-NN with 10 repeated 10 fold Cross Validation",
       subtitle = "Accuracy ",
       color = "Legend") +
  scale_color_manual(values = colors) +
  theme(legend.position = "top",
        axis.title.y = element_blank()) 

############################################### Random Forest Model
EconCost <- function(data, lev = NULL, model = NULL)
{
  y.pred = data$pred
  y.true = data$obs
  CM = confusionMatrix(y.pred, y.true)$table
  out = sum(as.vector(CM)*cost.p)/sum(CM)
  names(out) <- c("EconCost")
  out
}
# 
ctrl <- trainControl(method = "cv", number = 5,#set cross-validation control to 5-fold
                     classProbs = TRUE, 
                     summaryFunction = EconCost,
                     verboseIter=T)
#100 trees
#set cutoff 
RF_train <- randomForest(DEATH_EVENT ~., 
                         data=edx,
                         ntree=100,mtry=5,cutoff=c(0.6,0.4),importance=TRUE, do.trace=T)

plot(RF_train)

RF_pred <- predict(RF_train, newdata=validation)
confusionMatrix (RF_pred, validation$DEATH_EVENT)

######################################### ROC CURVE(KNN)
head(Hearts_UCI,2)
Hearts_UCI$DEATH_EVENT <- as.numeric (Hearts_UCI$DEATH_EVENT)
test_index2 <- createDataPartition(y = Hearts_UCI$DEATH_EVENT,
                                   times = 1, p = 0.2, list = FALSE) 

edx_rocknn <- Hearts_UCI[-test_index,]  
validation_rocknn <- Hearts_UCI[test_index,] # we will use it only to do final test

model2roclmm<-  knn(train=edx_rocknn[,1:13], test=validation_rocknn[,1:13],cl=edx_rocknn$DEATH_EVENT, k=5,prob=TRUE)
prob <- attr(model2roclmm, "prob")
prob <- ifelse(model2roclmm == "0", 1-prob, prob)

pred_knn <- prediction(prob, validation_rocknn$DEATH_EVENT)
pred_knn <- performance(pred_knn, "tpr", "fpr")
plot(pred_knn, avg= "threshold", lwd=1, main="kNN ROC Curve at K=5")

######################################### PARAMETER FINE TUNINING(Random Forest)
RF_train_tuning <- train(DEATH_EVENT ~.,
                         method = "rf",
                         data=edx,
                         # data=train_set,
                         preProcess = c("center", "scale"),
                         ntree = 100,
                         cutoff=c(0.6,0.4),
                         tuneGrid = expand.grid(mtry=c(4,5,6)),
                         maximize = F,
                         trControl = control)

summary(RF_train_tuning)
typeof(RF_train_tuning)

########################################### RISK FACTORS VATIABLE IMPORTANCE(Random Forest)
RF_imp <- varImp (RF_train, scale=F)
typeof(RF_imp)
print(RF_imp)

plot(RF_imp)
varImpPlot(RF_train, type=2)
 
################################################ SECOND ROUND OF TRAINING / TESTING(Random Forest model)
#5 trees for 2nd time 
RF_train_2nd <- randomForest(DEATH_EVENT ~., 
                             data=train_set2,
                             ntree=5,mtry=5,cutoff=c(0.6,0.4),importance=TRUE, do.trace=T)

################################################ Second SAMPLE(Training Test split)
RF_pred_set2 <- predict(RF_train_2nd, newdata=test_set2)

confusionMatrix (RF_pred_set2, test_set2$DEATH_EVENT)

