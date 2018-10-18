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
              
              numericInput("age", "How old are you?",value="none"),
              numericInput("num_adul", "Number of adults in the household",value="none"),
              numericInput("num_child", "Number of children if applicable",value="none"),
              
              
              selectInput("gender","Gender",choices=list("Female"=1,"Male"=2,"Other/Prefer not to say"=3),selected=1),
             
              radioButtons("visit_freq1", "How long did it pass since your last dental visit?",
                           choices = list("6 months or less" = 1, "1 year or less"=2, "1-2 years" = 3,"More than 2 years"=4),selected = 4),
              radioButtons("visit_freq2", "How often do you go to the dentist?",
                           choices = list("Every 6 months" = 1, "Every 1 year"=2, "Every 2 years" = 3,"Less often"=4, "Only in pain/emergency"=5),selected = 5),
              radioButtons("visit_reason", "Why did you last go to the dentist?",
                           choices = list("Check-up appointment" = 1, "Appointment for treatment"=2, "Emergency/pain" = 3,"Other"=4),selected = 4),
              textInput("text1", h3("If you selected Other, please specify:"), value = "Enter text if you selected other in the previous question")
              
            ),
            
            
            
            
            
            mainPanel(plotOutput("distPlot"),downloadButton("downloadfirstplot","Download Graph"), textOutput("message1"))
          )
      ),
      div(class = "page",
          id = paste0("step", 2),
          column(12,align="center",tags$h1("Demographics Part B")),
          sidebarLayout(
            sidebarPanel(
              
              radioButtons("ethnicity", "What is your ethnicity?",
                           choices = list("White" = 1, "Mixed/ Multiple ethnic groups"=2, "Asian/ Asian British" = 3,"Black / African / Caribbean / Black British"=4,
                                          "Other" = 5),selected = 5),
              textInput("text2", h3("If you selected Other, please specify:"), value = "Enter text if you selected other in the previous question"),
              radioButtons("oral_condition","How healthy are your teeth?",choices = list("None left" = 1, "Poor"=2, "Average" = 3,"Good"=4,
                                                                                         "Excellent" = 5),selected = 5),
              radioButtons("visit_pay","Do you usually pay for treatment? ",choices = list("Yes" = 1, "No"=2),selected = 2),
              radioButtons("visit_dread","Do you enjoy or dread a visit to the dentist? ",choices = list("Enjoy" = 1, "Don't mind"=2, "Dread" = 3),selected = 3),
              radioButtons("income","Which category does your annual income belong to?",choices = list("Less than 6800£" = 1, "6801-11000£"=2, "11001-17000£" = 3,"17001-25700£"=4,
                                                                                         "More than 25700£" = 5),selected = 5),
              radioButtons("education","What is your level of education? ",choices = list("No formal qualifications" = 1, "GCSE/ O Level/ Equivalent"=2, "A Level/ Highers/ Equivalent" = 3,"Undergraduate degree/ Professional equivalent"=4,
                                                                                         "Postgraduate degree/ Professional equivalent" = 5),selected = 5),
              radioButtons("region", "Where do you live?",
                           choices = list("North West of England" = 1, "Yorkshire and the Humber"=2, "North East of England" = 3,"East Midlands"=4,
                                          "London" = 5, "West Midlands"=6, "South West of England"=7,"East of England"=8,"South East of England"=9, "Scotland"=10, "Ireland"=11,"Wales"=12),selected = 12)
            ),
            
            mainPanel(plotOutput("SecondDistPlot"),textOutput ("message2"))
          )
      ),
            
      div(class = "page",
          id = paste0("step", 3),
          column(12,align="left",tags$h1("First choice")),
          br(),
          fluidRow(
          column(12,align="left",tags$h4("In each of the questions below, imagine you are going to register with a dental practice. You will be shown the features of a typical",tags$b("check-up appointment"), "for two",tags$b("hypothetical"),"dental practices. Based on these features, you should choose which you would register with. Imagine there are no options available apart from the two practices shown. Assume also that in both practices you will initially see the dentist for scaling and polishing of 20 minutes and hence practices vary only on", tags$b("the described features."),"The descriptions of features are presented on the table below.")),
          br(),
          column(12,align="left",tags$img(height=400, width=800, src="descriptions.png"))
          ),
          choiceDataTableUI("one")
      ),
      div(class = "page",
          id = paste0("step", 4),
          column(12,align="left",tags$h1("Second choice")),
          br(),
          fluidRow(
            column(12,align="left",tags$h4("In each of the questions below, imagine you are going to register with a dental practice. You will be shown the features of a typical",tags$b("check-up appointment"), "for two",tags$b("hypothetical"),"dental practices. Based on these features, you should choose which you would register with. Imagine there are no options available apart from the two practices shown. Assume also that in both practices you will initially see the dentist for scaling and polishing of 20 minutes and hence practices vary only on", tags$b("the described features."),"The descriptions of features are presented on the table below.")),
            br(),
            column(12,align="left",tags$img(height=400, width=800, src="descriptions.png"))
          ),
          choiceDataTableUI("two")
      ),
      div(class = "page",
          id = paste0("step", 5),
          column(12,align="left",tags$h1("Third choice")),
          br(),
          fluidRow(
            column(12,align="left",tags$h4("In each of the questions below, imagine you are going to register with a dental practice. You will be shown the features of a typical",tags$b("check-up appointment"), "for two",tags$b("hypothetical"),"dental practices. Based on these features, you should choose which you would register with. Imagine there are no options available apart from the two practices shown. Assume also that in both practices you will initially see the dentist for scaling and polishing of 20 minutes and hence practices vary only on", tags$b("the described features."),"The descriptions of features are presented on the table below.")),
            br(),
            column(12,align="left",tags$img(height=400, width=800, src="descriptions.png"))
          ),
          choiceDataTableUI("three")
      ),
      div(class = "page",
          id = paste0("step", 6),
          column(12,align="left",tags$h1("Fourth choice")),
          br(),
          fluidRow(
            column(12,align="left",tags$h4("In each of the questions below, imagine you are going to register with a dental practice. You will be shown the features of a typical",tags$b("check-up appointment"), "for two",tags$b("hypothetical"),"dental practices. Based on these features, you should choose which you would register with. Imagine there are no options available apart from the two practices shown. Assume also that in both practices you will initially see the dentist for scaling and polishing of 20 minutes and hence practices vary only on", tags$b("the described features."),"The descriptions of features are presented on the table below.")),
            br(),
            column(12,align="left",tags$img(height=400, width=800, src="descriptions.png"))
          ),
          choiceDataTableUI("four")
      ),
      
      div(class = "page",
          id = paste0("step", 7),
          column(12,align="left",tags$h1("Fifth choice")),
          br(),
          fluidRow(
            column(12,align="left",tags$h4("In each of the questions below, imagine you are going to register with a dental practice. You will be shown the features of a typical",tags$b("check-up appointment"), "for two",tags$b("hypothetical"),"dental practices. Based on these features, you should choose which you would register with. Imagine there are no options available apart from the two practices shown. Assume also that in both practices you will initially see the dentist for scaling and polishing of 20 minutes and hence practices vary only on", tags$b("the described features."),"The descriptions of features are presented on the table below.")),
            br(),
            column(12,align="left",tags$img(height=400, width=800, src="descriptions.png"))
          ),
          choiceDataTableUI("five")
      ),
      div(class = "page",
          id = paste0("step", 8),
          column(12,align="left",tags$h1("Sixth choice")),
          br(),
          fluidRow(
            column(12,align="left",tags$h4("In each of the questions below, imagine you are going to register with a dental practice. You will be shown the features of a typical",tags$b("check-up appointment"), "for two",tags$b("hypothetical"),"dental practices. Based on these features, you should choose which you would register with. Imagine there are no options available apart from the two practices shown. Assume also that in both practices you will initially see the dentist for scaling and polishing of 20 minutes and hence practices vary only on", tags$b("the described features."),"The descriptions of features are presented on the table below.")),
            br(),
            column(12,align="left",tags$img(height=400, width=800, src="descriptions.png"))
          ),
          choiceDataTableUI("six")
      ),
      div(class = "page",
          id = paste0("step", 9),
          column(12,align="left",tags$h1("Seventh choice")),
          br(),
          fluidRow(
            column(12,align="left",tags$h4("In each of the questions below, imagine you are going to register with a dental practice. You will be shown the features of a typical",tags$b("check-up appointment"), "for two",tags$b("hypothetical"),"dental practices. Based on these features, you should choose which you would register with. Imagine there are no options available apart from the two practices shown. Assume also that in both practices you will initially see the dentist for scaling and polishing of 20 minutes and hence practices vary only on", tags$b("the described features."),"The descriptions of features are presented on the table below.")),
            br(),
            column(12,align="left",tags$img(height=400, width=800, src="descriptions.png"))
          ),
          choiceDataTableUI("seven")
      ),
      div(class = "page",
          id = paste0("step", 10),
          fluidPage(
            div(
              id="lastpage",
          column(12,align="left",tags$h1("Eighth choice")),
          br(),
          fluidRow(
            column(12,align="left",tags$h4("In each of the questions below, imagine you are going to register with a dental practice. You will be shown the features of a typical",tags$b("check-up appointment"), "for two",tags$b("hypothetical"),"dental practices. Based on these features, you should choose which you would register with. Imagine there are no options available apart from the two practices shown. Assume also that in both practices you will initially see the dentist for scaling and polishing of 20 minutes and hence practices vary only on", tags$b("the described features."),"The descriptions of features are presented on the table below.")),
            br(),
            column(12,align="left",tags$img(height=400, width=800, src="descriptions.png"))
          ),
          

          choiceDataTableUI("eight"),
          actionButton("submit", "Submit", class = "btn-primary")
          ),
          shinyjs::hidden(
          div(
          id = "thankyou_msg",
          h3("Thanks, your response was submitted successfully!")
      ))))
      #div(class = "page",
          #id = paste0("step", 10),
          #column(12,align="left",tags$h1("Questions of attitudes")),
          #br(),
          #fluidRow(
            #column(12,align="left",tags$h4("Please rate the following statements on a scale from strongly disagree to stongly agree, according to your opinion"))
          #),
          #fluidPage(
            #column(12, align = "center",
                   #div(
                     #id = "likert_input",
                     
                     #likertQuestionsInput("likert", questions = c("I believe that there is likelihood to get tooth decay",
                                                                  #"I believe that there is possibility of getting gum disease",
                                                                  #"I am too busy to visit a dentist",
                                                                  #"I do not think that the money spent on dental care are worth",
                                                                  #"I believe that tooth decay is a serious problem",
                                                                  #"I believe in adverse effect of dental problems on my health",
                                                                  #"I believe that getting sick is a matter of luck",
                                                                  #"I believe myself as being healthier than the average person",
                                                                  #"I believe that taking care of myself can avoid illness",
                                                                  #"I am confident that I can brush all my teeth and not just the front, visible ones",
                                                                  #"I am confident that I can apply flossing properly",
                                                                  #"I am confident that I can brush my teeth more than twice a day, if I think that there is a good reason for doing so (eg, I have eaten sweets)"), choices = likert_choices,
                                          #selected = "Neutral")
                     
                  # )))),
     # div(class = "page",
         # id = paste0("step", 11),
        
         # fluidPage(
            
            #column(12, align = "center",
                  # div(
                    # id = "levelanx_input",
                    # column(12,align="left",tags$h1("Questions of attitudes")),
                    # br(),
                    # fluidRow(
                      # column(12,align="left",tags$h4("Please rate the following statements on a scale from slightly anxious to extremely anxious, according to how you feel about the following statements"))
                     #),
                     #likertQuestionsInput("levelanx", questions=c("If you went to your dentist for treatment tomorrow, how would you feel?",
                                                                  #"If you were sitting in the waiting room (waiting for treatment), how would you feel?",
                                                                  #"If you were about to have a tooth drilled, how would you feel?",
                                                                  #"If you were about to have your teeth scaled and polished, how would you feel?"),
                                         # choices=levelanx_choices, selected="Fairly Anxious"),
                     
                     
                     
                     
                     #actionButton("submit", "Submit", class = "btn-primary")
                  # ),
                  # shinyjs::hidden(
                     #div(
                       #id = "thankyou_msg",
                      # h3("Thanks, your response was submitted successfully!"),
                      # plotOutput("likert_plot"),
                     #  plotOutput("Anx_plot")
                    # )
                 # )
            #)
         # )
      #)
    )
    
  ),
  
  
  
  br(),
  column(12, align = "center",
         actionButton("prevBtn", "< Previous"),
         actionButton("nextBtn", "Next >")
  )
 )
