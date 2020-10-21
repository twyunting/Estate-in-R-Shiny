# Yunting Chiu

library(shiny)
library(ggplot2)
library(readr)
estate <- read_csv("../data/estate.csv")

ui <- fluidPage(
    
    titlePanel("EDA of Estate Data"),
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            varSelectInput("var", "Variable?", data = estate),
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
            tabsetPanel(type = "tabs",
                        tabPanel("Plot", plotOutput("plot")),
                        tabPanel("Summary", verbatimTextOutput("summary")),
                        tabPanel("Table", tableOutput("table"))
            )# tabsetPanel
            
        )# mainPanel
    )# sidebarLayout
)# fluidPage

# Define server logic required to draw a histogram
server <- function(input, output) {


}

# Run the application 
shinyApp(ui = ui, server = server)
