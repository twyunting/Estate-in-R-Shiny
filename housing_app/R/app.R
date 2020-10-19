# Yunting Chiu

library(shiny)
library(tidyverse)
estate <- read_csv("../data/estate.csv")

ui <- fluidPage(

    # Application title
    titlePanel("EDA of Estate Data"),

    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Input: Select the random distribution type ----
            varSelectInput("Variable", "Variable?", data = estate),
            
            # br() element to introduce extra vertical spacing ----
            br(),
            
            # Input: Slider for the number of observations to generate ----
            sliderInput("n",
                        "Number of Bins:",
                        value = 500,
                        min = 1,
                        max = 100)
            
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: Tabset w/ plot, summary, and table ----
            tabsetPanel(type = "tabs",
                        tabPanel("Plot", plotOutput("plot")),
                        tabPanel("Summary", verbatimTextOutput("summary")),
                        tabPanel("Table", tableOutput("table"))
            )
            
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {


}

# Run the application 
shinyApp(ui = ui, server = server)
