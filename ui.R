ui <- fluidPage(
  #tags$head(
    #tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.min.css")
  #),
  
  useShinyjs(),
  hidden(
    list(
      div(class = "page",
          id = paste0("step", 1),
          column(12,align="center",tags$h1("General Public App")),
          fluidRow(
            column(12, align="center",tags$h3("If you need further information about the project, visit:",tags$a(href="http://advocateoralhealth.com/","Advocate Project"))),
          br(),
          column(12, align="left",tags$h4("We are preparing to do a survey looking at what features people prefer when signing up to a new dental practice. Before the main part of the survey, we 'd like you to provide us with some information about your oral health profile. Please have a look on the following questions and answer appropriately.")),
          br(),
          column(12, align="left",tags$h5(" The interrupted lines of the graph below will show you where you lie across all survey participants' oral health behaviour or in other words how compliant your oral health profile is", tags$b("(the more to the right the better!)"), "After answering the first four questions check your graph and the popped up message below it! Are you a master of oral health behaviour? Download and share your graph with your Facebook friends to show them how much you have mastered oral health prevention behaviour! Continue with the following questions. "))
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
            
            
            
            
            
            mainPanel(plotOutput("distPlot"),downloadButton("downloadfirstplot","Download Graph"), textOutput("message"))
          )
      ),
      div(class = "page",
          id = paste0("step", 2),
          column(12,align="left",tags$h1("First set of choices")),
          br(),
          fluidRow(
          column(12,align="left",tags$h4("In each of the questions below, imagine you are going to register with a dental practice. You will be shown the features of a typical",tags$b("check-up appointment"), "for two",tags$b("hypothetical"),"dental practices. Based on these features, you should choose which you would register with. Imagine there are no options available apart from the two practices shown. Assume also that in both practices you will initially see the dentist for scaling and polishing of 20 minutes and hence practices vary only on", tags$b("the described features."),"The descriptions of features are presented on the table below.")),
          br(),
          column(12,align="left",tags$img(height=400, width=800, src="descriptions.png"))
          ),
          choiceDataTableUI("one"),
          choiceDataTableUI("two"),
          choiceDataTableUI("three"),
          choiceDataTableUI("four")
      ),
      div(class = "page",
          id = paste0("step", 3),
          column(12,align="left",tags$h1("Second set of choices")),
          br(),
          fluidRow(
            column(12,align="left",tags$h4("Please continue choosing which dental practice you would register with in each question based on the same rationale as in the previous page")),
            br(),
            column(12,align="left",tags$img(height=400, width=800, src="descriptions.png"))
          ),
          choiceDataTableUI("five"),
          choiceDataTableUI("six"),
          choiceDataTableUI("seven"),
          choiceDataTableUI("eight")
      ),
      div(class = "page",
          id = paste0("step", 4),
          column(12,align="left",tags$h1("Questions of attitudes")),
          br(),
          fluidRow(
            column(12,align="left",tags$h4("Please rate the following statements on a scale from strongly disagree to stongly agree, according to your opinion"))
          ),
          fluidPage(
            column(12, align = "center",
                   div(
                     id = "likert_input",
                     
                     likertQuestionsInput("likert", questions = c("I believe that there is likelihood to get tooth decay",
                                                                  "I believe that there is possibility of getting gum disease",
                                                                  "I am too busy to visit a dentist",
                                                                  "I do not think that the money spent on dental care are worth",
                                                                  "I believe that tooth decay is a serious problem",
                                                                  "I believe in adverse effect of dental problems on my health",
                                                                  "I believe that getting sick is a matter of luck",
                                                                  "I believe myself as being healthier than the average person",
                                                                  "I believe that taking care of myself can avoid illness",
                                                                  "I am confident that I can brush all my teeth and not just the front, visible ones",
                                                                  "I am confident that I can apply flossing properly",
                                                                  "I am confident that I can brush my teeth more than twice a day, if I think that there is a good reason for doing so (eg, I have eaten sweets)"), choices = likert_choices,
                                          selected = "Neutral")
                     
                   )))),
      div(class = "page",
          id = paste0("step", 5),
        
          fluidPage(
            
            column(12, align = "center",
                   div(
                     id = "levelanx_input",
                     column(12,align="left",tags$h1("Questions of attitudes")),
                     br(),
                     fluidRow(
                       column(12,align="left",tags$h4("Please rate the following statements on a scale from slightly anxious to extremely anxious, according to how you feel about the following statements"))
                     ),
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