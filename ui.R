ui <- fluidPage(
  #tags$head(
    #tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.min.css")
  #),
  
  useShinyjs(),
  hidden(
    list(
      div(class = "page",
          id = paste0("step", 1),
          column(12,align="center",tags$h1("Preferences of oral health prevention")),
          fluidRow(
            
          column(12, align="left",tags$h4("This survey is assessing what features people prefer when signing up to a new dental practice. Please read through and answer the following questions. There are no right or wrong answers. We are interested in your own honest, personal opinions.")),
          br(),
          column(12, align="left",tags$h5("This questionnaire is organised into",tags$b(" two parts."),"The",tags$b("First part"), "asks you to provide some information about you, your perceived oral health and some behaviours related to that. ")),
          br(),
          column(12, align="left",tags$h5("The", tags$b("second part"), "presents you with eight scenarios. You will then be asked in each scenario to select which dental practice you would like to register at for a",tags$b(" dental check-up appointment."),"For each scenario we would like you to imagine you are going to register with a", tags$b("new"), "dental practice for a first time. You will be given options of a", tags$b("typical check-up appointment"), "for two", tags$b("hypothetical"),"dental practices and",tags$b("you will be required to choose"),"which you would like to register with", tags$b("based on the options presented.")))
          #br(),
          ),
          
          mainPanel() 
          
        ),
    div(class = "page",
          id = paste0("step", 2),
          column(12,align="left",tags$h1("Demographics Part A")),
          br(),
          column(12, align="left",tags$h5(" The interrupted lines of the graph below will show you where you lie across all survey participants' oral health behaviour or in other words how compliant your oral health profile is", tags$b("(the more on the right the better!)"), "After answering the first four questions check your graph and the popped up message! Are you a master of oral health behaviour?")),
          br(),
          column(12, align="left",tags$h5("Download, rename, save and share your graph with your Facebook friends to show them how much you have mastered oral health preventive behaviour! Continue with the following questions.")), 
          br(),
          
          
          sidebarLayout(
            sidebarPanel(
              sliderInput("var1","how many times do you brush your teeth per week?",0,56,1,ticks=FALSE),
              numericInput("min_brush","How long on average have you been brushing your teeth for each time? (in minutes)", value = 1),
              sliderInput("var2","how many times do you clean between your teeth, using an interdental cleaner (like floss) per week?",0,56,1,ticks=FALSE),
              numericInput("min_floss","How long on average have you been cleaning between your teeth using an interdental cleaner (like floss) for each time? (in minutes)",value=1), 
              
              numericInput("age", "How old are you?",value="none"),
              
              
              
              selectInput("gender","Gender",choices=list("Female"=1,"Male"=2,"Other/Prefer not to say"=3),selected=1),
             
              radioButtons("visit_freq1", "When did you last visit a dentist about your teeth, dentures or gums?",
                           choices = list("Less than 1 year ago" = 1, "1 to less than 2 years ago"=2, "2 or more years ago" = 3,"I have never attended"=4, "I can't remember"=5),selected = 5),
              conditionalPanel(
                condition="input.visit_freq1 == 1 || input.visit_freq1 == 2 ||input.visit_freq1 == 3",
              radioButtons("visit_freq2", "How often do you go to the dentist?",
                           choices = list("Every 6 months" = 1, "Every 1 year"=2, "Every 2 years" = 3,"Less often"=4, "Only in pain/emergency"=5, "I have never visited the dentist"=6),selected = 0)),
       
              radioButtons("visit_reason", "What was the reason for your last visit to the dentist?",
                           choices = list("Check-up, examination or cleaning" = 1, "Planned treatment (e.g. routine filling or extraction)"=2, "Emergency treatment" = 3," I do not know"=4, "Other"=5),selected = 5),
              textInput("text1", h3("If you selected Other, please specify:")),
              
              radioButtons("alchohol", "What is your average alchohol consumption weekly?",
                           choices = list("0-1 drinks/week" = 1, "1-4 drinks/week"=2, "5-14 drinks/week" = 3,"15 or more drinks/week"=4),selected = 4)
              
            ),
            
            
            
            
            
            mainPanel(plotOutput("distPlot"),downloadButton("downloadfirstplot","Download Graph"),textOutput("message1"))
          )
      ),
      div(class = "page",
          id = paste0("step", 3),
          column(12,align="left",tags$h1("Demographics Part B")),
          sidebarLayout(
            sidebarPanel(
              
              radioButtons("ethnicity", "What is your ethnicity?",
                           choices = list("White" = 1, "Mixed/ Multiple ethnic groups"=2, "Asian/ Asian British" = 3,"Black / African / Caribbean / Black British"=4,
                                          "Other" = 5),selected = 5),
              textInput("text2", h3("If you selected Other, please specify:")),
              radioButtons("oral_condition","How healthy do you think your teeth are? (See how many responsents think they are in the same condition with you at the graph on your right. The interrupted line corresponds to the number of people with the same perceived oral health situation)",choices = list("None left" = 1, "Poor"=2, "Average" = 3,"Good"=4,
                                                                                         "Excellent" = 5),selected = 5),
              radioButtons("visit_pay","How do you pay for your dental care and treatment? ",choices = list("Partially (covered by the NHS or a public medical scheme)" = 1, "Partially (covered by a private insurance scheme"=2, "Completely by myself"=3, "Private insurance scheme"=4, "I do not pay"=5, "I do not know"=6),selected = 6),
              
              radioButtons("visit_dread","Do you enjoy or dread a visit to the dentist? ",choices = list("Enjoy" = 1, "Don't mind"=2, "Dread" = 3),selected = 3),
              radioButtons("smoking_status","What is your smoking status?",choices = list("I have never smoked" = 1, "I am a former smoker"=2, "I am a current smoker" = 3),selected = 3),
              radioButtons("education","What is your highest level of education? ",choices = list("No education" = 1, "Primary education (elementary school / left school at age 11-14)"=2, "Secondary school (left school after age 14 without qualification)" = 3,"Pre-vocational / vocational education (GCSEs, Standard Grade, GNVQ Foundation & Intermediate, NVQ levels 1 and 2)"=4,
                                                                                         "Pre-vocational / vocational education (GCSE A/AS levels, Higher Grade, CSYS, GNVQ Advanced, NVQ Level 3)" = 5, "Vocational qualification (qualification in higher education)"=6, "University (Bachelor, Master and doctoral degree)"=7, "Prefer not to say"=8),selected = 0),
              radioButtons("sug_bev","What is your average daily consumption of sugared beverages? Note: Sugared beverages include fruit juice, soft drink, cordial, energy drinks or flavoured milk.",choices = list("0-1 per day" = 1, "2-3 times per day"=2, "4 or more times per day" = 3),selected = 0),
              radioButtons("working_status","What is your working status?",choices = list("Full time work (35 hours per week)" = 1, "Part time work (less than 35 hours per week)"=2, "More than 35 hours per week" = 3, "Unemployed"=4),selected = 0),
              
              radioButtons("profession","Given the categories below, where do you think your profession belongs most suitably to? ",choices = list("Service class: professionals, administrators and managers; higher grade technicians; supervisors of non-manual workers" = 1, "Routine non-manual workers: routine non-manual employees in administration and commerce; sales personnel"=2, "Small properties and artisans and so on, with and without employees" = 3,"  Farmers and smallholders and other self-employed workers in primary production"=4,
                                                                                                  "Non-skilled workers: semi- and unskilled manual workers (not in agriculture etc.)" = 5, "Agricultural labourers: agricultural and other workers in primary production"=6, "Never worked or long term unemployed"=7),selected = 0),
              radioButtons("region", "Where do you live?",
                           choices = list("England" = 1, "Scotland"=2, "Wales" = 3,"Ireland"=4),selected = 0),
              conditionalPanel(
                condition = "input.region == 1",
                radioButtons("Eng.region", "In which English region are you currently living?",
                             choices = list("North West of England" = 1, "Yorkshire and the Humber"=2, "North East of England" = 3,"East Midlands"=4,
                                            "London" = 5, "West Midlands"=6, "South West of England"=7,"East of England"=8,"South East of England"=9),selected = 0)), 
              conditionalPanel(  
                condition = "input.region == 2", 
                textInput("Scot.city","In which city in Scotland are you currently living?")),
              conditionalPanel(  
                condition = "input.region == 3", 
                textInput("Wal.city","In which city in Wales are you currently living?")),
              conditionalPanel(  
                condition = "input.region == 4", 
                textInput("Ire.city","In which city in Ireland are you currently living?"))
            ),
            
            mainPanel(plotOutput("SecondDistPlot"),textOutput ("message2"))
          )
      ),
            
      div(class = "page",
          id = paste0("step", 4),
          column(12,align="left",tags$h1("Choice 1")),
          br(),
          fluidRow(
          column(12,align="left",tags$h4("For each scenario below we would like you to imagine you are going to register with a",tags$b("new"), "dental practice for a first time. You will be given options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices", tags$b("and you will be required to choose"), "which you would like to register with", tags$b("based on the options presented."), "Here follows a table describing the changing options for the dental practices. Please read through the table before answering the questions.")),
          br(),
          column(12,align="left",tags$img(height=400, width=850, src="descriptions.png")),
          br(),
          column(12,align="left",tags$h4("In the question below, imagine you are going to register with a", tags$b("new dental practice."), "You will be shown the options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices.")),
          br(),
          column(12,align="left",tags$h4("Based on these options, you should choose which practice you would register with.")),
          br(),
          column(12,align="left",tags$h4("Imagine there are no options available apart from the two practices shown. In both practices you will initially see the dentist for a scale and polish which will take about 15 minutes. The only variation between practices is in the options below.")), 
          column(12,align="left",tags$h4(tags$b("Which dental practice would you choose?")))
          ),
          choiceDataTableUI("one")
      ),
      div(class = "page",
          id = paste0("step", 5),
          column(12,align="left",tags$h1("Choice 2")),
          br(),
          fluidRow(
            #column(12,align="left",tags$h4("For each scenario below we would like you to imagine you are going to register with a",tags$b("new"), "dental practice for a first time. You will be given options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices", tags$b("and you will be required to choose"), "which you would like to register with", tags$b("based on the options presented."), "Here follows a table describing the changing options for the dental practices. Please read through the table before answering the questions.")),
            #br(),
            #column(12,align="left",tags$img(height=400, width=850, src="descriptions.png")),
            #br(),
            column(12,align="left",tags$h4("In the question below, imagine you are going to register with a", tags$b("new dental practice."), "You will be shown the options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices.")),
            br(),
            column(12,align="left",tags$h4("Based on these options, you should choose which practice you would register with.")),
            br(),
            column(12,align="left",tags$h4("Imagine there are no options available apart from the two practices shown. In both practices you will initially see the dentist for a scale and polish which will take about 15 minutes. The only variation between practices is in the options below.")), 
            column(12,align="left",tags$h4(tags$b("Which dental practice would you choose?")))
          ),
          choiceDataTableUI("two")
      ),
      div(class = "page",
          id = paste0("step", 6),
          column(12,align="left",tags$h1("Choice 3")),
          br(),
          fluidRow(
            #column(12,align="left",tags$h4("For each scenario below we would like you to imagine you are going to register with a",tags$b("new"), "dental practice for a first time. You will be given options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices", tags$b("and you will be required to choose"), "which you would like to register with", tags$b("based on the options presented."), "Here follows a table describing the changing options for the dental practices. Please read through the table before answering the questions.")),
            #br(),
            #column(12,align="left",tags$img(height=400, width=850, src="descriptions.png")),
            #br(),
            column(12,align="left",tags$h4("In the question below, imagine you are going to register with a", tags$b("new dental practice."), "You will be shown the options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices.")),
            br(),
            column(12,align="left",tags$h4("Based on these options, you should choose which practice you would register with.")),
            br(),
            column(12,align="left",tags$h4("Imagine there are no options available apart from the two practices shown. In both practices you will initially see the dentist for a scale and polish which will take about 15 minutes. The only variation between practices is in the options below.")), 
            column(12,align="left",tags$h4(tags$b("Which dental practice would you choose?")))
          ),
          choiceDataTableUI("three")
      ),
      div(class = "page",
          id = paste0("step", 7),
          column(12,align="left",tags$h1("Choice 4")),
          br(),
          fluidRow(
            #column(12,align="left",tags$h4("For each scenario below we would like you to imagine you are going to register with a",tags$b("new"), "dental practice for a first time. You will be given options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices", tags$b("and you will be required to choose"), "which you would like to register with", tags$b("based on the options presented."), "Here follows a table describing the changing options for the dental practices. Please read through the table before answering the questions.")),
            #br(),
            #column(12,align="left",tags$img(height=400, width=850, src="descriptions.png")),
            #br(),
            column(12,align="left",tags$h4("In the question below, imagine you are going to register with a", tags$b("new dental practice."), "You will be shown the options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices.")),
            br(),
            column(12,align="left",tags$h4("Based on these options, you should choose which practice you would register with.")),
            br(),
            column(12,align="left",tags$h4("Imagine there are no options available apart from the two practices shown. In both practices you will initially see the dentist for a scale and polish which will take about 15 minutes. The only variation between practices is in the options below.")), 
            column(12,align="left",tags$h4(tags$b("Which dental practice would you choose?")))
          ),
          choiceDataTableUI("four")
      ),
      
      div(class = "page",
          id = paste0("step", 8),
          column(12,align="left",tags$h1("Choice 5")),
          br(),
          fluidRow(
            #column(12,align="left",tags$h4("For each scenario below we would like you to imagine you are going to register with a",tags$b("new"), "dental practice for a first time. You will be given options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices", tags$b("and you will be required to choose"), "which you would like to register with", tags$b("based on the options presented."), "Here follows a table describing the changing options for the dental practices. Please read through the table before answering the questions.")),
            #br(),
            #column(12,align="left",tags$img(height=400, width=850, src="descriptions.png")),
            #br(),
            column(12,align="left",tags$h4("In the question below, imagine you are going to register with a", tags$b("new dental practice."), "You will be shown the options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices.")),
            br(),
            column(12,align="left",tags$h4("Based on these options, you should choose which practice you would register with.")),
            br(),
            column(12,align="left",tags$h4("Imagine there are no options available apart from the two practices shown. In both practices you will initially see the dentist for a scale and polish which will take about 15 minutes. The only variation between practices is in the options below.")), 
            column(12,align="left",tags$h4(tags$b("Which dental practice would you choose?")))
          ),
          choiceDataTableUI("five")
      ),
      div(class = "page",
          id = paste0("step", 9),
          column(12,align="left",tags$h1("Choice 6")),
          br(),
          fluidRow(
            #column(12,align="left",tags$h4("For each scenario below we would like you to imagine you are going to register with a",tags$b("new"), "dental practice for a first time. You will be given options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices", tags$b("and you will be required to choose"), "which you would like to register with", tags$b("based on the options presented."), "Here follows a table describing the changing options for the dental practices. Please read through the table before answering the questions.")),
            #br(),
            #column(12,align="left",tags$img(height=400, width=850, src="descriptions.png")),
            #br(),
            column(12,align="left",tags$h4("In the question below, imagine you are going to register with a", tags$b("new dental practice."), "You will be shown the options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices.")),
            br(),
            column(12,align="left",tags$h4("Based on these options, you should choose which practice you would register with.")),
            br(),
            column(12,align="left",tags$h4("Imagine there are no options available apart from the two practices shown. In both practices you will initially see the dentist for a scale and polish which will take about 15 minutes. The only variation between practices is in the options below.")), 
            column(12,align="left",tags$h4(tags$b("Which dental practice would you choose?")))
          ),
          choiceDataTableUI("six")
      ),
      div(class = "page",
          id = paste0("step", 10),
          column(12,align="left",tags$h1("Choice 7")),
          br(),
          fluidRow(
            #column(12,align="left",tags$h4("For each scenario below we would like you to imagine you are going to register with a",tags$b("new"), "dental practice for a first time. You will be given options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices", tags$b("and you will be required to choose"), "which you would like to register with", tags$b("based on the options presented."), "Here follows a table describing the changing options for the dental practices. Please read through the table before answering the questions.")),
            #br(),
            #column(12,align="left",tags$img(height=400, width=850, src="descriptions.png")),
            #br(),
            column(12,align="left",tags$h4("In the question below, imagine you are going to register with a", tags$b("new dental practice."), "You will be shown the options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices.")),
            br(),
            column(12,align="left",tags$h4("Based on these options, you should choose which practice you would register with.")),
            br(),
            column(12,align="left",tags$h4("Imagine there are no options available apart from the two practices shown. In both practices you will initially see the dentist for a scale and polish which will take about 15 minutes. The only variation between practices is in the options below.")), 
            column(12,align="left",tags$h4(tags$b("Which dental practice would you choose?")))
          ),
          choiceDataTableUI("seven")
      ),
    
    div(class = "page",
        id = paste0("step", 11),
        column(12,align="left",tags$h1("Choice 8")),
        br(),
        fluidRow(
          #column(12,align="left",tags$h4("For each scenario below we would like you to imagine you are going to register with a",tags$b("new"), "dental practice for a first time. You will be given options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices", tags$b("and you will be required to choose"), "which you would like to register with", tags$b("based on the options presented."), "Here follows a table describing the changing options for the dental practices. Please read through the table before answering the questions.")),
          #br(),
          #column(12,align="left",tags$img(height=400, width=850, src="descriptions.png")),
          #br(),
          column(12,align="left",tags$h4("In the question below, imagine you are going to register with a", tags$b("new dental practice."), "You will be shown the options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices.")),
          br(),
          column(12,align="left",tags$h4("Based on these options, you should choose which practice you would register with.")),
          br(),
          column(12,align="left",tags$h4("Imagine there are no options available apart from the two practices shown. In both practices you will initially see the dentist for a scale and polish which will take about 15 minutes. The only variation between practices is in the options below.")), 
          column(12,align="left",tags$h4(tags$b("Which dental practice would you choose?")))
        ),
        choiceDataTableUI("eight")
    ),    
      div(class = "page",
          id = paste0("step", 12),
          fluidPage(
            div(
              id="lastpage",
          column(12,align="left",tags$h1("Feedback")),
          br(),
          fluidRow(
            #column(12,align="left",tags$h4("For each scenario below we would like you to imagine you are going to register with a",tags$b("new"), "dental practice for a first time. You will be given options of a typical", tags$b("check-up appointment"), "for two", tags$b("hypothetical"), "dental practices", tags$b("and you will be required to choose"), "which you would like to register with", tags$b("based on the options presented."), "Here follows a table describing the changing options for the dental practices. Please read through the table before answering the questions.")),
            #br(),
            #column(12,align="left",tags$img(height=400, width=800, src="descriptions.png")),
            #br(),
            column(12,align="left",tags$h4("Consider the questions we asked above. On a scale from 1 to 7 indicate how much you agree with the following statements (1=strongly disagree, 7=strongly agree)."))),
          
          br(),
          sidebarLayout(
            sidebarPanel(
              sliderInput("Feed1","I understood the questions.",0,7,1,ticks=FALSE),
              sliderInput("Feed2","I understood the options of each scenario.",0,7,1,ticks=FALSE),
              sliderInput("Feed3","The hypothetical dental practices were realistic",0,7,1,ticks=FALSE),
              sliderInput("Feed4","All the important information I needed was there.",0,7,1,ticks=FALSE),
              textInput("Feed5", "Was there anything you found difficult to understand?"),
              textInput("Feed6", "Was any information missing which would be vital for your decision?"),
              textInput("Feed7", "Please provide any additional comment you might have here."),
              textInput("Feed8", "Please provide your email address if you would like feedback on this survey"),
              column(12,align="left",tags$h4("Please contact Evangelos Zormpas with any questions or queries:",tags$b("dnez@leeds.ac.uk"))),
              #br(),
              #column(12, align="center",tags$h3("If you need further information about the project, visit:",tags$a(href="http://advocateoralhealth.com/","Advocate Project"))),
              
              actionButton("submit", "Submit", class = "btn-primary")
            ),
            mainPanel()
          )

          
          
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


