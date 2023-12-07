#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  #Lingfeng___________________________________________________
  textOutput(outputId = "TituloSal"),
  plotOutput(outputId = "distPlot"),
  textOutput(outputId = "TituloLang"),
  plotOutput(outputId = "langPlot"),
  textOutput(outputId = "MixtSalLang"),
  plotOutput(outputId = "MixtPlot"),
  #___________________________________________________________
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    #Lingfeng___________________________________________________
    output$TituloSal <- renderText("The mean salary based on the working experience on IT fields")
    output$distPlot <- renderPlot(plot_Salary)
    output$TituloLang <- renderText("This is a mean salary for each language depending on the mean salary")
    output$langPlot <- renderPlot(plot_Lang)
    output$MixtSalLang <- renderText("This is a plot where is a mixt of the previus two where the value of each language of the market can be aprecciated")
    output$MixtPlot <- renderPlot(plot_Mixt)
    #___________________________________________________________
}
# Run the application 
shinyApp(ui = ui, server = server)
