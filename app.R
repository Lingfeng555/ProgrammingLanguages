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

    # Application title
    titlePanel("No se bro el titulo y esas cosas hermano"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 0,
                        max = 50,
                        value = 1)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot"),
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
        )
    )
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
    
    # -------- SALARIES --------
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        plot_Salary
    })
    
    # -------- POPULAR IDEs --------
    output$pythonPlot <- renderPlot({
      ide_plot_list[["Python"]]
    })
    
    output$javaPlot <- renderPlot({
      ide_plot_list[["Java"]]
    })
    
    output$javaScriptPlot <- renderPlot({
      ide_plot_list[["JavaScript"]]
    })
    
    output$rPlot <- renderPlot({
      ide_plot_list[["R"]]
    })
    
    output$cPlot <- renderPlot({
      ide_plot_list[["C"]]
    })
    
    output$cppPlot <- renderPlot({
      ide_plot_list[["C++"]]
    })
    
    output$asmPlot <- renderPlot({
      ide_plot_list[["Assembly"]]
    })
    
    output$htmlPlot <- renderPlot({
      ide_plot_list[["HTML/CSS"]]
    })
    
    output$phpPlot <- renderPlot({
      ide_plot_list[["PHP"]]
    })
    
    output$kotlinPlot <- renderPlot({
      ide_plot_list[["Kotlin"]]
    })
    
    output$fortranPlot <- renderPlot({
      ide_plot_list[["Fortran"]]
    })
    
    output$rustPlot <- renderPlot({
      ide_plot_list[["Rust"]]
    })
    
    output$swiftPlot <- renderPlot({
      ide_plot_list[["Swift"]]
    })
    
    output$sqlPlot <- renderPlot({
      ide_plot_list[["SQL"]]
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
