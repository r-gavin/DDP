#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
      
      # Application title
      titlePanel("Plot Random Generated Numbers"),
      
      # Sidebar with a slider input for number of bins 
      sidebarLayout(
            sidebarPanel(
                  numericInput("numeric","Pick how many random numbers to generate:",
                               min = 1,max = 1000,step = 1,value = 500),
                  sliderInput("sliderX","Pick X min and max",
                              min = -100,max = 100,value = c(-50,50)),
                  sliderInput("sliderY","Pick Y min and max",
                              min = -100,max = 100,value = c(-50,50)),
                  checkboxInput("show_xlab","Show/Hide X label",value = TRUE),
                  checkboxInput("show_ylab","Show/Hide Y label",value = TRUE),
                  checkboxInput("show_title","Show/Hide Title",value = TRUE),
                  textInput("title_text","Set Plot Name",
                            placeholder = "Insert Your Title Here")
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
                  plotOutput("plot1")
            )
      )
))
