# Finalizing the Model

# It looks like the results for the Cubist algorithm are the most accurate. Let's finalize it by
# creating a new standalone Cubist model with the parameters above trained using the whole
# dataset. We must also use the Box-Cox power transform.

# prepare the data transform using training data
set.seed(7)
x <- training[,5:6]
y <- training[,4]
preprocessParams <- preProcess(x, method=c("BoxCox"))
transX <- predict(preprocessParams, x)

# train the final model
finalModel <- cubist(x=transX, y=y, committees=18)
summary(finalModel)

finalModel$coefficients

# Making predictions
# We can now use this model to evaluate our held-out validation dataset. Again, we must
# prepare the input data using the same Box-Cox transform.

# transform the testing dataset
set.seed(7)
valX <- testing[,5:6]
trans_valX <- predict(preprocessParams, valX)
valY <- testing[,4]

# use final model to make predictions on the testing dataset

predictions <- predict(finalModel, newdata=trans_valX, neighbors=7)

# calculate RMSE
rmse <- RMSE(predictions, valY)
r2 <- R2(predictions, valY)
print(rmse)
print(r2)