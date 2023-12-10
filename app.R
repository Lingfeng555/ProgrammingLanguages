#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(lubridate)
library(ggplot2)
library(RColorBrewer)

# Define UI for application that draws a histogram
ui <- fluidPage(
      
  
    # Application title
    titlePanel("A brief summary of programing languages"),
    # Asier 
    titlePanel("Popularity of all programing languages every month of the year"),
    sidebarLayout(
        sidebarPanel(
          sliderInput(inputId = "Year",
                    "Year:",
                    min = 2004,
                    max = 2023,
                    value = 2004),
          sliderInput(inputId = "Month",
                    "Month:",
                    min = 1,
                    max = 12,
                    value = 7)
      ),
      mainPanel(
        # Aquí puedes colocar cualquier contenido adicional para el panel principal
        plotOutput(outputId = "popularityPie"),
        textOutput(outputId = "plotAclaration")
      )
    ),
    #Lingfeng___________________________________________________
    titlePanel("The popularity of each language based on issues on github repos"),
    fluidPage(
      textInput(label = "FirstLanguage", inputId = "Lang1", value = "Python"),
      textInput(label = "SecondLanguage", inputId = "Lang2", value = "R"),
      plotOutput(outputId = "LangCompare")
    ),
    
    #Asier
    titlePanel("Most required programing languages"),
    plotOutput(outputId = "requiredPlot"),
    
    #Lingfeng
    titlePanel("How is each language in the job market"),
    textOutput(outputId = "TituloSal"),
    plotOutput(outputId = "distPlot"),
    textOutput(outputId = "TituloLang"),
    plotOutput(outputId = "langPlot"),
    textOutput(outputId = "MixtSalLang"),
    plotOutput(outputId = "MixtPlot"),
  #___________________________________________________________

    titlePanel("Popular ID for each programming language"),
    mainPanel(
        tabsetPanel(
            tabPanel("Python", plotOutput("pythonPlot")),
            tabPanel("Java", plotOutput("javaPlot")),
            tabPanel("JavaScript", plotOutput("javaScriptPlot")),
            tabPanel("R", plotOutput("rPlot")),
            tabPanel("C", plotOutput("cPlot")),
            tabPanel("C++", plotOutput("cppPlot")),
            tabPanel("Assembly", plotOutput("asmPlot")),
            tabPanel("HTML/CSS", plotOutput("htmlPlot")),
            tabPanel("PHP", plotOutput("phpPlot")),
            tabPanel("Kotlin", plotOutput("kotlinPlot")),
            tabPanel("Fortran", plotOutput("fortranPlot")),
            tabPanel("Rust", plotOutput("rustPlot")),
            tabPanel("Swift", plotOutput("swiftPlot")),
            tabPanel("SQL", plotOutput("sqlPlot"))
        )
    ),
    
    mainPanel(
        titlePanel("Employment"),
    
        mainPanel(plotOutput(outputId = "devTypePlot")),
        mainPanel(plotOutput(outputId = "edLevelPlot"))
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
    # -------- Popularity --------
    
    output$popularityPie <- renderPlot({
      popularityPie <- createPopularityPie(input$Month, input$Year)
      print(popularityPie)
    })
    output$plotAclaration <- renderText("The  values of the plot are from July 2004 (older) to May 2023(newest)")
  
    output$requiredPlot <- renderPlot({
      requiredPlot <- createMostRequiredPie()
      print(requiredPlot)
    })
    
    output$LangCompare <-  renderPlot(plotCompareLanguage(input$Lang1, input$Lang2))
  
    # -------- SALARIES --------
  
    output$TituloSal <- renderText("The mean salary based on the working experience on IT fields")
    output$distPlot <- renderPlot(plot_Salary)
    output$TituloLang <- renderText("This is a mean salary for each language depending on the mean salary")
    output$langPlot <- renderPlot(plot_Lang)
    output$MixtSalLang <- renderText("This is a plot where is a mixt of the previus two where the value of each language of the market can be aprecciated")
    output$MixtPlot <- renderPlot(plot_Mixt)

    
    # -------- POPULAR IDEs --------
    output$pythonPlot <- renderPlot({ide_plot_list[["Python"]]})
    output$javaPlot <- renderPlot({ide_plot_list[["Java"]]})
    output$javaScriptPlot <- renderPlot({ide_plot_list[["JavaScript"]]})
    output$rPlot <- renderPlot({ide_plot_list[["R"]]})
    output$cPlot <- renderPlot({ide_plot_list[["C"]]})
    output$cppPlot <- renderPlot({ide_plot_list[["C++"]]})
    output$asmPlot <- renderPlot({ide_plot_list[["Assembly"]]})
    output$htmlPlot <- renderPlot({ide_plot_list[["HTML/CSS"]]})
    output$phpPlot <- renderPlot({ide_plot_list[["PHP"]]})
    output$kotlinPlot <- renderPlot({ide_plot_list[["Kotlin"]]})
    output$fortranPlot <- renderPlot({ide_plot_list[["Fortran"]]})
    output$rustPlot <- renderPlot({ide_plot_list[["Rust"]]})
    output$swiftPlot <- renderPlot({ide_plot_list[["Swift"]]})
    output$sqlPlot <- renderPlot({ide_plot_list[["SQL"]]})
    
    # -------- Employment by Dev Type --------
    output$devTypePlot <- renderPlot(devType_employment_plot, width = 800)
    
    # -------- Employment by Education Level --------
    output$edLevelPlot <- renderPlot(edLevel_employment_plot, width = 800)
}
# Run the application 
shinyApp(ui = ui, server = server)
