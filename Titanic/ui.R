library(shiny)

# Define UI for application that draws a histogram
shinyUI(pageWithSidebar(
  headerPanel("Titanic Wyrocznia"),
  sidebarPanel(
    radioButtons("sex", label = h3("Płeć:"),
                 choices = list("Kobieta" = "female", "Mężczyzna" = "male"), 
                 selected = "female"),
    sliderInput("age", label = h3("Wiek:"), 
                min = 0, max = 100, value = 25),
    selectInput("class", label =h3("Typ biletu:"), 
                list("Pierwsza klasa" = "1","Druga klasa" = "2", "Trzecia klasa" = "3"))),
  mainPanel(
    h3("Pradopodobieństwo przeżycia"),
    h3(textOutput('prob')),
    imageOutput("life"))))
