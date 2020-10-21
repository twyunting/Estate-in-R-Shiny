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
    
    titlePanel("EDA of Estate Data"),
    tabsetPanel(
        tabPanel("Histogram", plotOutput("hist")
        ),
        tabPanel("Density", plotOutput("density")
        ),
        tabPanel("Boxplot", plotOutput("box")
        )
    ), # tabsetPanel
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            varSelectInput("var", "Variable?", data = estate, selected = "Price($K)"),
            checkboxInput("log", "Log_Transform?"),
            sliderInput("n",
                        "Number of Bins?",
                        value = 40,
                        min = 1,
                        max = 100),
            textInput("null", "Null Value", value = 0)
            
        ),#sidebarPanel
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: Tabset w/ plot, summary, and table ----
           
            
        )# mainPanel
    )# sidebarLayout
)# fluidPage

# Define server logic required to draw a histogram
server <- function(input, output) {


}

# Run the application 
shinyApp(ui = ui, server = server)
