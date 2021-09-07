fluidPage(theme = shinytheme("cerulean"),
  # Application title
  titlePanel(title=div(img(src="https://images.vexels.com/media/users/3/193073/isolated/lists/797b0d45317985fb24e04cd5e323081c-covid-19-2019-icono-de-accidente-cerebrovascular-ncov.png", height = 50, width = 50,), "COVID Data")),

  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      selectInput(inputId="country_selection", "Choose a country:",
                  choices = countries,multiple = TRUE, selected = "Argentina"),
      hr(),
      selectInput(inputId="graph_selection", "Choose variable:",
                  choices = graph_options),
      hr(),
      dateRangeInput("dates", "Select date:",start = min(unique(df$date)), end = max(unique(df$date)),separator = " to ")
    ),

    # Show output
    
    mainPanel(
      tabsetPanel(
        tabPanel("Graphic",plotOutput("plot")),
        tabPanel("Worlwide heatmap",div(h3(textOutput("wt"))),
                 plotOutput("Worldplot")),
        tabPanel("Forecast"),
        id="tab"
    )
    )
  
  ),
  hr(),
  print(paste("Data provided by Our World in Data")),
  br(),
  print(paste("Developed by Felipe Moronta and Juan Ignacio Goldberg"))
)
