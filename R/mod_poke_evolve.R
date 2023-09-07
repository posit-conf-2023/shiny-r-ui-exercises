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
mod_poke_evolve_server <- function(id, selected, is_shiny) {
  moduleServer(id, function(input, output, session) {

    # Render the evolution UI on the server side
    output$poke_evolve <- renderUI({
      # Tips
      # selected() contains the selected Pokemon data
      # You can inspect it with listviewer::jsonedit(selected())
      req(!is.null(selected()))
      evol <- selected()$evolve_from

      # If pokemon can't evolve ...
      if (length(evol) == 0) {
        # WORKSHOP TO DO
        # What do we show we the Pokemon can't evolve?
      } else {
        # Check that the evolution belongs to the first 151 pkmns ...
        if (evol$id <= 151) {
          # WORKSHOP TO DO
          # Show UI element for Pokemon evolution
        } else {
          # WORKSHOP TO DO
          # What should we display if the Pokemon
          # evolution is not part of the first 151 Pokemon.
          # (In other words, when the evolution was added after
          # the first generation)?
        }
      }
    })
  })
}
