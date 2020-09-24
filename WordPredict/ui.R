#library(shiny)
#library(rsconnect)
shinyUI(fluidPage(
    
    titlePanel("Predictive keyboard"),
    tabsetPanel(type='tab',
                tabPanel("App Main Page",
                         sidebarLayout(
                             
                             sidebarPanel(
                                 textInput('userInput',label="Input your word or phrase here:",value="I want to..."),
                                 #actionButton('goButton',"Guess!"),
                                 br(),
                                 helpText("Note:",br(),
                                          "The following predicted word will show up automatically as you input.")),
                             
                             mainPanel(
                                 h4("These are the top 10 predictions:"),
                                 tableOutput('guess')
                             )
                         )
                ),
                
                tabPanel("Summary Dataset",
                         h3("Dataset Summary"),
                         img(src="fileSummary.png"),
                         h3("Wordcloud of the sample corpus of data"),
                         img(src="wordcloud.png", width='525px', height='375px'),
                         #h5("Header 5")
                         
                )
    ),
    hr(),
    h5("For more information of exploratory analysis of dateset, please refer to my milestone document."),
    a(p("LINK"), href="https://rpubs.com/Reza_Mofidi/654311")
)
)