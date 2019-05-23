##1. Input configuration

#loading packages and import database
library(e1071)
library(data.table)
exchangeGBP<-read.csv("exchangeGBP.csv")
str(exchangeGBP)

#input selection & set taining and testing data group
exchange<-exchangeGBP[1:500,2]
exchange_table0<-shift(exchange, n=0:500, fill=0, type="lead",give.names =T)
setDF(exchange_table0)
exchange_table<-exchange_table0[1:496,1:5]
setnames(exchange_table,1:5,c("day1","day2","day3","day4","day5"))
ExchangeTrain0<-exchange_table[1:396,]
ExchangeTest0<-exchange_table[397:496,]
ExchangeTrain_input<-ExchangeTrain0[,1:4]
ExchangeTrain_output<-ExchangeTrain0$day5
exchange_train_original_day5 <- exchange_table[1:396,"day5"]
exchange_test_original_day5 <- exchange_table[397:496,"day5"]



##2. SVR with various structures and parameters

#SVR with various structures and parameters
svm_tune <- tune(svm,day5~ .,data= ExchangeTrain0,kernel="radial", ranges=list(cost=10^(-3:2),gamma=10^(-3:-1)))
summary(svm_tune)
svm_tune <- tune(svm,day5~ .,data= ExchangeTrain0,kernel="sigmoid", ranges=list(cost=10^(-3:2),gamma=10^(-3:-1)))
summary(svm_tune)
svm_tune <- tune(svm,day5~ .,data= ExchangeTrain0,kernel="poly", ranges=list(cost=10^(-3:2),gamma=10^(-3:-1)))
summary(svm_tune)
svm_tune <- tune(svm,day5~ .,data= ExchangeTrain0,kernel="linear", ranges=list(cost=10^(-3:2),gamma=10^(-3:-1)))
summary(svm_tune)
svm_tune <- tune(svm,day5~ .,data= ExchangeTrain0,kernel="radial", ranges=list(cost=10^(2:4),gamma=10^(-3:-1)))
summary(svm_tune)
svm_tune <- tune(svm,day5~ .,data= ExchangeTrain0,kernel="sigmoid", ranges=list(cost=10^(2:4), gamma=10^(-3:-1)))
summary(svm_tune)
svm_tune <- tune(svm,day5~ .,data= ExchangeTrain0,kernel="poly", ranges=list(cost=10^(3:4),gamma=10^(-3:-1)))
summary(svm_tune)
svm_tune <- tune(svm,day5~ .,data= ExchangeTrain0,kernel="linear", ranges=list(cost=10^(3:4),gamma=10^(-3:-1)))
summary(svm_tune)
svm_tune <- tune(svm,day5~ .,data= ExchangeTrain0,kernel="radial", ranges=list(cost=10^(2:4),gamma=10^(-3:-1), epsilon=0.01))
summary(svm_tune)



##3. Results with graphs and performance indices

#after tune -- apply the best resultes and evaluate
svm_model_after_tune <- svm(day5 ~ ., data=ExchangeTrain0, kernel="radial", cost=100,gamma=0.001)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)
rmse <- function(x)
{
sqrt(mean(x^2))
}
mape <- function(actual,pred){
mape <- mean(abs((actual - pred)/actual))
}

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
svm_model_after_tune <- svm(day5 ~ ., data=ExchangeTrain0, kernel="radial", cost=10,gamma=0.001)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
svm_model_after_tune <- svm(day5 ~ ., data=ExchangeTrain0, kernel="sigmoid", cost=10, gamma=0.001)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
svm_model_after_tune <- svm(day5 ~ ., data=ExchangeTrain0, kernel="sigmoid", cost=100,gamma=0.001)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
svm_model_after_tune <- svm(day5 ~ ., data=ExchangeTrain0, kernel="poly", cost=100,gamma=0.1)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
svm_model_after_tune <-svm(day5 ~ ., data=ExchangeTrain0, kernel="poly", cost=10, gamma=0.1)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
svm_model_after_tune <- svm(day5 ~ gamma=0.01)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
108.svm_model_after_tune <- svm(day5 ~ ., data=ExchangeTrain0, kernel="linear", cost=100,gamma=0.1)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2

#adjust the epsilon values
svm_tune <- tune(svm, day5~ ., data = ExchangeTrain0,ranges = list(epsilon = seq(0,1,0.01), cost =2^(2:9)))
summary(svm_tune)
svm_tune <- tune(svm, day5~ ., data = ExchangeTrain0, kernel="radial", ranges = list(epsilon =seq(0,1,0.01), cost =10^(-1:2)))
summary(svm_tune)

#after tune
svm_model_after_tune <-svm(day5 ~ ., data=ExchangeTrain0, kernel="linear", cost=4, gamma=0.1,epsilon=0.01)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
svm_model_after_tune <- svm(day5 ~ ., data=ExchangeTrain0, kernel="poly", cost=0.001, gamma=0.1,epsilon=1)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
svm_model_after_tune <- svm(day5 ~ ., data=ExchangeTrain0, kernel="radial", cost=100,gamma=0.01,epsilon=0.01)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
svm_model_after_tune <- svm(day5 ~ ., data=ExchangeTrain0, kernel="radial", cost=1,gamma=0.01,epsilon=0.01)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
svm_model_after_tune <- svm(day5 ~ ., data=ExchangeTrain0, kernel="radial", cost=1,gamma=1,epsilon=0.01)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2
svm_model_after_tune <- svm(day5 ~ ., data=ExchangeTrain0, kernel="radial", cost=1, gamma=0.1,epsilon=0.01)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2

#graph
svm_model_after_tune <-svm(day5 ~ ., data=ExchangeTrain0, kernel="linear", cost=4, gamma=0.1,epsilon=0.01)
summary(svm_model_after_tune)
pred_after_tune<- predict(svm_model_after_tune,ExchangeTest0[1:4])
cor(pred_after_tune, ExchangeTest0$day5)

error2 <- (exchange_test_original_day5 - pred_after_tune )
pred_RMSE2 <- rmse(error2)
pred_RMSE2
pred_MAPE2<-mape(exchange_test_original_day5,pred_after_tune)
pred_MAPE2

par(mfrow=c(1,1))
plot(exchange_test_original_day5,pred_after_tune ,col='red',main='Real vs predicted SVR',pch=18,cex=0.7)
abline(0,1,lwd=2)
legend('bottomright',legend='SVR', pch=18,col='red', bty='n')

