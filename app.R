blc <- read_csv("blc.csv")
#build basic ui
library(ggplot2)
library(tidyverse)
library(shiny)
library(shiny)
attach(blc)

ui <- fluidPage( #add tittle
  titlePanel("BC Liquor store prices"),
  #Add layout
  sidebarLayout(
    sidebarPanel(
      #INPUT XOR PRODUCT TYPE
      sliderInput("priceInput","Price",0,100,c(25,40),pre="$"),
      radioButtons("typeInput","Product type",
                   choices = c("BEER","REFRESHMENT","SPIRITS","WINE"),
                   selected = "WINE"),
      #INPUT FOR COUNTRY
      
      selectInput("countryInput","Country",
                  choices = c("CANADA","FRANCE","ITALY"))
    ),
    mainPanel(
      plotOutput("coolplot"),
      br(),
      br(),
      tableOutput("results")
    )
  )
 
  
)

server <- function(input, output) {
  output$coolplot<-renderPlot({
    filtered<-
      blc %>% 
      filter(Price>=input$priceInput[1],
             Price<=input$priceInput[2],
             Type==input$typeInput,
             Country==input$countryInput)
    ggplot(filtered,aes(Alcohol_Content))+
      geom_histogram()
  })
  
}

shinyApp(ui, server)