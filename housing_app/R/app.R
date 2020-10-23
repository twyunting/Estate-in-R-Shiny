# Yunting Chiu

library(shiny)
library(tidyverse)

# Transform the data so AC, Pool and Highway are factors and Price is in thousands of dollars.
estate <- read_csv("../data/estate.csv",
                   col_types = cols("AC" = col_factor(),
                                    "Pool" = col_factor(),
                                    "Highway" = col_factor())) %>%
    mutate(Price = Price/1000) %>%
    rename("Price($K)" = "Price")  %>%
    mutate(AC = fct_recode(AC, "Presence" = "1", "Absence" = "0"),
           Pool = fct_recode(Pool, "Pool" = "1", "No Pool" = "0"),
           Highway = fct_recode(Highway, "Adjacent" = "1", "Not Adjacent" = "0")) -> estate


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
                         numericInput("mu", "Null Value", value = 0),
                         tableOutput("table")
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
                               checkboxInput("OLS", "Fit OLS?")
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
    
    output$plot1 <- renderPlot({
        pl1 <- ggplot(estate, aes(x = !!input$var1))
        if(is.factor(estate[[input$var1]])){ # 3 variable is factor.
          pl1 <- pl1 + geom_bar()  
        }else if(is.numeric(estate[[input$var1]])){
            if(input$log1){
                pl1 <- pl1 + geom_histogram(bins = input$bins) +
                    scale_x_log10() +
                    labs(x = paste("Log(",input$var1,")"))
            }else{
                pl1 <- pl1 + geom_histogram(bins = input$bins)
            }
        }else{
            pl1 <- pl1 + geom_boxplot()
        }
        pl1
    })# renderplot
        
    output$table <- renderTable({
        if(is.numeric(estate[[input$var1]])) {
           if(!!input$log1){
               estate %>%
                   select(!!input$var1) %>%
                   log() %>%
                   t.test(alternative = "two.sided", 
                          mu = input$mu , conf.level = 0.95) %>% 
                   broom::tidy() %>%
                   select("P-value" = p.value, "Estimate" = estimate,
                          "95 % Lower" = conf.low, "95 % Upper" = conf.high)
        }else{
            estate %>%
                select(!!input$var1) %>%
                t.test(alternative = "two.sided", 
                       mu = input$mu , conf.level = 0.95) %>% 
                broom::tidy() %>%
                select("P-value" = p.value, "Estimate" = estimate,
                       "95 % Lower" = conf.low, "95 % Upper" = conf.high)
        }
        }else{
            print("Variable is not numeric")
        }
    })# renderTable

}# server 

# Run the application 
shinyApp(ui = ui, server = server)
