library(shiny)
library(dplyr)
library(caret)
library(scales)

data <- read.csv("titanic.csv", header = TRUE, sep = ",") %>% 
  select(c(Survived, Pclass, Sex, Age)) %>% 
  na.omit()

data$Age <- sapply(data$Age, as.integer)
data$Pclass <- sapply(data$Pclass, as.factor)

input <- data[1]

model <- train(Survived ~ Pclass + Sex + Age, data, method="glm")

predict_prob <- function(class, sex, age) {
  input[1, 'Survived'] <- NA
  input[1, 'Pclass'] <- class
  input[1, 'Sex'] <- sex
  input[1, 'Age'] <- age
  print(data[1, ])
  survive <- predict(model, input)
  if(survive < 0){
    survive = 0
  }
  if(survive > 1){
    survive = 1
  }
  return(survive)
}

shinyServer(
  function(input, output) {
    output$prob <- renderText({
      percent(predict_prob(input$class, input$sex, input$age))
    })
    output$life <- renderImage({
      if(predict_prob(input$class, input$sex, input$age) > 0.5){
        return(list(
          src = "images/life.jpg",
          alt = "Life"
        ))
      }
      else{
        return(list(
          src = "images/dead.jpg",
          alt = "Dead"
        ))
      }
    }, deleteFile = FALSE)
  })