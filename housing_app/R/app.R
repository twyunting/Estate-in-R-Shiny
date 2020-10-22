# Yunting Chiu

library(shiny)
library(tidyverse)

# Transform the data so AC, Pool and Highway are factors and Price is in thousands of dollars.
estate <- read_csv("../data/estate.csv",
                   col_types = cols("AC" = col_factor(),
                                    "Pool" = col_factor(),
                                    "Highway" = col_factor())) %>%
    mutate(Price = round(Price/1000)) %>%
    rename("Price($K)" = "Price") -> estate

ui <- fluidPage(
    titlePanel("EDA of Estate Data", windowTitle = "EDA of Estate Data"),
    tabsetPanel(type = "tabs",
        tabPanel("Univariate",
                 sidebarLayout(
                     sidebarPanel(
                         varSelectInput("var1", "Variable?", 
                                        data = estate, selected = "Price($K)"),
                         checkboxInput("log1", "Log_Transform?"),
                         sliderInput("bins",
                                     "Number of Bins?",
                                     value = 40,
                                     min = 1,
                                     max = 100),
                         numericInput("null", "Null Value", value = 0)
                         
                     ),
                mainPanel(plotOutput("plot1")
                )#sidebarPanel
            )# sidebarLayout
        ),# tabPanel
        tabPanel("Bivariate",
                 sidebarLayout(
                     sidebarPanel(
                         varSelectInput("var2X", "X Variable?",
                                              data = estate, selected = "Price($K)"),
                               checkboxInput("log2X", "Log_Transform?"),
                               varSelectInput("var2Y", "Y Variable?",
                                              data = estate, selected = "Price($K)"),
                               checkboxInput("log2Y", "Log_Transform?"),
                               checkboxInput("OLS", "fit OLS?")
                     ),
                mainPanel(plotOutput("plot2")
                )#sidebarPanel
            )#sidebarLayout
        ), # tabPanel
       tabPanel("SpreadSheet",
                dataTableOutput("sheets")
        )# tabPanel
    )# tabsetPanel
)# fluidPage


# Output
server <- function(input, output) {


}

# Run the application 
shinyApp(ui = ui, server = server)
