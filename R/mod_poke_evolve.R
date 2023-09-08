

  #' poke_evolve UI Function
  #'
  #' @description A  Module.
  #'
  #' @param id,input,output,session Internal parameters for {}.
  #'
  #' @noRd
  mod_poke_evolve_ui <- function(id) {
    ns <- NS(id)
    uiOutput(ns("poke_evolve"))
  }

  #' poke_evolve Server Functions
  #'
  #' @param selected Selected pokemon data.
  #' @param is_shiny Is the pokemon under its shiny form?
  #'
  #' @noRd
  mod_poke_evolve_server <- function(id, selected) {
    moduleServer(id, function(input, output, session) {

      # treat data and generate the timeline
      output$poke_evolve <- renderUI({
        req(!is.null(selected()))
        evol <- selected()$evolve_from

        img <- NULL
        # If pokemon can't evolve ...
        if (length(evol) == 0) {
          tags$div(
            tags$p("Base Pokemon", class="evolution-text-inside"),
          )
        } else {
          # Check that the evolution belongs to the first 151 pkmns ...
          if (evol$id <= 151) {
            tags$div(
              tags$p("Evolves From", class="evolution-text"),
              tags$img(
                src = poke_data[[evol$id]]$sprites$front_shiny,
              )
            )
          } else {
            tags$div(
              tags$p("Not first generation", class="evolution-text-inside"),
            )
          }
        }

      })
    })
  }
