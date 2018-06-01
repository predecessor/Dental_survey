ui <- fluidPage(
  useShinyjs(),
  hidden(
    list(
      div(class = "page",
          id = paste0("step", 1),
          column(12,align="center",tags$h1("General Public App")),
          fluidRow(
            column(12, align="center",tags$h3("If you need further information about the project, visit:",tags$a(href="http://advocateoralhealth.com/","Advocate Project")))
          ),
          sidebarLayout(
            sidebarPanel(
              sliderInput("var1",labelMandatory("how many times do you brush your teeth per week?"),0,56,1,ticks=FALSE),
              numericInput("min_brush","How long on average have you been brushing your teeth for each time? (in minutes)", value = 1),
              sliderInput("var2",labelMandatory("how many times do you clean between your teeth, using an interdental cleaner (like floss) per week?"),0,56,1,ticks=FALSE),
              numericInput("min_floss","How long on average have you been cleaning between your teeth using an interdental cleaner (like floss) for each time? (in minutes)",value=1), 
              radioButtons("age", "Age groups (please choose in which age group you belong to)",
                           choices = list("16-24" = 1, "25-34"=2, "35-44" = 3,"45-54"=4,
                                          "55+" = 5),selected = 5),
              
              selectInput("ethnicity","Ethnicity",choices=list("White"=1,"Hispanic or Latino"=2,"Black or African American"=3,"Native American or American Indian"=4,"Asian/Pacific Islander"=5,"Other"=6),selected=6),
              
              selectInput("gender","Gender",choices=list("Female"=1,"Male"=2,"Prefer not to say"=3),selected=1),
              selectInput("education",
                          "Level of education completed",
                          choices=list("No formal schooling"=1,"Less than primary school"=2,"Primary school completed"=3,"Secondary school completed"=4,"High school completed"=5,"Colege/University completed"=6,"Postgraduate degree"=7),selected =7),
              radioButtons("visit_freq", "How long is it since you last saw a dentist?",
                           choices = list("Less than 6 months" = 1, "6-12 months"=2, "More than 1 year but less than 2 years" = 3,"2 years or more but less than 5 years"=4,
                                          "5 years or more" = 5, "Never received dental care"=6),selected = 6),
              
              sliderInput("oral_condition","Number of sound teeth",1,32,1,ticks=FALSE),
              radioButtons("occupation", "Occupational status (please choose which professional status you fit into)",
                           choices = list("Employed for wages" = 1, "Self-employed"=2, "Out of work and looking for work" = 3,"Out of work but not currently looking for work"=4,
                                          "A homemaker" = 5, "A student"=6, "Military"=7,"Retired"=8,"Unable to work"=9),selected = 9),
              
              
              selectInput("alcohol","During the past 30 days, on the days you drank alcohol, how many drinks did you usually drink per day?",choices=list("Less than a drink"=1,"1 drink"=2,"2 drinks"=3,"3 drinks"=4,"4 drinks"=5,"5 or more drinks"=6, "Did not drink alcohol during the past 30 days"=7),selected=7),
              radioButtons("region", "Where do you live?",
                           choices = list("North West" = 1, "Yorkshire and the Humber"=2, "North East" = 3,"East Midlands"=4,
                                          "London" = 5, "West Midlands"=6, "South West"=7,"East of England"=8,"South East"=9),selected = 9)
            ),
            
            
            
            
            
            mainPanel(plotOutput("distPlot"), textOutput("message"))
          )
      ),
      div(class = "page",
          id = paste0("step", 2),
          column(12,align="left",tags$h1("First set of choices")),
          choiceDataTableUI("one"),
          choiceDataTableUI("two"),
          choiceDataTableUI("three"),
          choiceDataTableUI("four")
      ),
      div(class = "page",
          id = paste0("step", 3),
          column(12,align="left",tags$h1("Second set of choices")),
          choiceDataTableUI("five"),
          choiceDataTableUI("six"),
          choiceDataTableUI("seven"),
          choiceDataTableUI("eight")
      ),
      div(class = "page",
          id = paste0("step", 4),
          column(12,align="left",tags$h1("Some questions")),
          fluidPage(
            column(12, align = "center",
                   div(
                     id = "likert_input",
                     
                     likertQuestionsInput("likert", questions = c("I believe that there is likelihood to get tooth decay",
                                                                  "I believe that there is possibility of getting gum disease",
                                                                  "I believe that my teeth condition is good", "I am too busy to visit a dentist",
                                                                  "I do not think that the money spent on dental care are worth",
                                                                  "I think that dental visit costs are too high","I believe that tooth decay is a serious problem",
                                                                  "I believe in adverse effect of dental problems on my health",
                                                                  "I believe in the effectiveness of dental visits to prevent tooth decay","I believe that getting sick is a matter of luck",
                                                                  "I believe myself as being healthier than the average person",
                                                                  "I believe that taking care of myself can avoid illness","I am able to find the energy to manage your dental or oral health",
                                                                  "I am able to fill in dental forms e.g. enrolment forms",
                                                                  "I am able to take a friend or family with you in the dental office",
                                                                  "I am able to pay to visit a dentist", "I am confident that I can brush all my teeth and not just the front, visible ones",
                                                                  "I am confident that I can apply flossing properly",
                                                                  "I am confident that I can brush my teeth more than twice a day, if I think that there is a good reason for doing so (eg, I have eaten sweets)"), choices = likert_choices,
                                          selected = "Neutral")
                     
                   )))),
      div(class = "page",
          id = paste0("step", 5),
          
          fluidPage(
            
            column(12, align = "center",
                   div(
                     id = "levelanx_input", column(12,align="left",tags$h1("Some additional questions")),
                     likertQuestionsInput("levelanx", questions=c("If you went to your dentist for treatment tomorrow, how would you feel?",
                                                                  "If you were sitting in the waiting room (waiting for treatment), how would you feel?",
                                                                  "If you were about to have a tooth drilled, how would you feel?",
                                                                  "If you were about to have your teeth scaled and polished, how would you feel?"),
                                          choices=levelanx_choices, selected="Fairly Anxious"),
                     
                     
                     
                     
                     actionButton("submit", "Submit", class = "btn-primary")
                   ),
                   shinyjs::hidden(
                     div(
                       id = "thankyou_msg",
                       h3("Thanks, your response was submitted successfully!"),
                       plotOutput("likert_plot"),
                       plotOutput("Anx_plot")
                     )
                   )
            )
          )
      )
    )
    
  ),
  
  
  
  br(),
  column(12, align = "center",
         actionButton("prevBtn", "< Previous"),
         actionButton("nextBtn", "Next >")
  )
)