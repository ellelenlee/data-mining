##1. Various input configurations

#loading packages and import database
library(ggplot2)
library(reshape2)
library(gridExtra)
library(neuralnet)
library(grid)
library(MASS)
library(data.table)
exchangeGBP<-read.csv("exchangeGBP.csv")
str(exchangeGBP)

#input selection
exchange<-exchangeGBP[1:500,2]
exchange_table0<-shift(exchange, n=0:500, fill=0, type="lead",give.names =T)
setDF(exchange_table0)
str(exchange_table0)
exchange_table<-exchange_table0[1:496,1:5]
setnames(exchange_table,1:5,c("day1","day2","day3","day4","day5"))
exchange_table



##2. Neural Network Model and Evaluation methods
##2.1 Normalize data & set training and testing data group

#normalization data & set taining and testing data group
melted_exchange_table = melt(exchange_table)
tail(melted_exchange_table)
qplot(x=value, data=melted_exchange_table) + facet_wrap(~variable, scales='free')
normalize <- function(x) {
return((x - min(x)) / (max(x) - min(x)))
}
Exchange_table_norm <- as.data.frame(lapply(exchange_table, normalize))
summary(Exchange_table_norm)
ExchangeTrain<-Exchange_table_norm[1:396,]
ExchangeTest<-Exchange_table_norm[397:496,]

##2.2 Training a Model using the neuralnet function

#Training a Model using the neuralnet function
set.seed(12345)
exchange_model <- neuralnet(day5 ~ day1 + day2 + day3 + day4, data = ExchangeTrain)
plot(exchange_model)
model_results <- compute(exchange_model, ExchangeTest[1:4])
predicted_exchange <- model_results$net.result
cor(predicted_exchange, ExchangeTest$day5)

##2.3 Evaluating Model Performance
##2.3.1 Unnormalized data

#Evaluating Model Performance (unnormalize the data)
head(predicted_exchange)
exchange_train_original_day5 <- exchange_table[1:396,"day5"]
exchange_test_original_day5 <- exchange_table[397:496,"day5"]
day5_min <- min(exchange_train_original_day5)
day5_max <- max(exchange_train_original_day5)
head(exchange_train_original_day5)
unnormalize <- function(x, min, max) {
return( (max - min)*x + min )
}
day5_pred <- unnormalize(predicted_exchange, day5_min, day5_max)
day5_pred

##2.3.2 RMSE, MAPE and Visual plot

#RMSE
rmse <- function(x)
{
sqrt(mean(x^2))
}
error <- (exchange_test_original_day5 - day5_pred )
pred_RMSE <- rmse(error)
pred_RMSE

#MAPE
mape <- function(actual,pred){
mape <- mean(abs((actual - pred)/actual))
}
pred_MAPE<-mape(exchange_test_original_day5,day5_pred)
pred_MAPE

# visual plot
par(mfrow=c(1,1))
plot(exchange_test_original_day5,day5_pred ,col='red',main='Real vs predicted NN',pch=18,cex=0.7)
abline(0,1,lwd=2)
legend('bottomright',legend='NN', pch=18,col='red', bty='n')

#comaparetion
final_result <- cbind(exchange_test_original_day5, day5_pred)
final_result



##3. MLPs and performances comparison

#Improving Model Performance
set.seed(12345)
exchange_model2 <- neuralnet(day5 ~ day1 + day2 + day3 + day4, data = ExchangeTrain, hidden = 10, act.fct='logistic', linear.output=TRUE)

#plot(exchange_model2)
model_results2 <- compute(exchange_model2, ExchangeTest[1:4])
predicted_exchange2 <- model_results2$net.result
cor(predicted_exchange2, ExchangeTest$day5)
day5_pred2 <- unnormalize(predicted_exchange2, day5_min, day5_max)

error2 <- (exchange_test_original_day5 - day5_pred2 )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,day5_pred2)
pred_MAPE2

#different input16. exchange_table2<-exchange_table0[1:497,1:4]
setnames(exchange_table2,1:4,c("day1","day2","day3","day4"))
melted_exchange_table2 = melt(exchange_table2)
Exchange_table_norm2 <- as.data.frame(lapply(exchange_table2, normalize))
ExchangeTrain2<-Exchange_table_norm2[1:397,]
ExchangeTest2<-Exchange_table_norm2[398:497,]

set.seed(12345)
exchange_model_1 <- neuralnet(day4 ~ day1 + day2 + day3, data = ExchangeTrain2)
plot(exchange_model_1)
model_results_1 <- compute(exchange_model_1, ExchangeTest2[1:3])
predicted_exchange_1 <- model_results_1$net.result
cor(predicted_exchange_1, ExchangeTest2$day4)

exchange_train_original_day4 <- exchange_table2[1:397,"day4"]
exchange_test_original_day4 <- exchange_table2[398:497,"day4"]
day4_min <- min(exchange_train_original_day4)
day4_max <- max(exchange_train_original_day4)
day4_pred_1 <- unnormalize(predicted_exchange_1, day4_min, day4_max)

error_1 <- (exchange_test_original_day4 - day4_pred_1 )
pred_RMSE_1 <- rmse(error_1)
pred_RMSE_1
pred_MAPE_1<-mape(exchange_test_original_day4,day4_pred_1)
pred_MAPE_1

set.seed(12345)
exchange_model_2 <- neuralnet(day4 ~ day1 + day2 + day3, data = ExchangeTrain2, hidden = 3,act.fct='logistic')
plot(exchange_model_2)
model_results_2 <- compute(exchange_model_2, ExchangeTest2[1:3])
predicted_exchange_2 <- model_results_2$net.result
cor(predicted_exchange_2, ExchangeTest2$day4)
day4_pred_2 <- unnormalize(predicted_exchange_2, day4_min, day4_max)

error_2 <- (exchange_test_original_day4 - day4_pred_2 )
pred_RMSE_2 <- rmse(error_2)
pred_RMSE_2
pred_MAPE_2<-mape(exchange_test_original_day4,day4_pred_2)




