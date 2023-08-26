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

    # treat data and generate the timeline
    output$poke_evolve <- renderUI({
      req(!is.null(selected()))
      evol <- selected()$evolve_from

      # If pokemon can't evolve ...
      if (length(evol) == 0) {
        tablerAlert(
          title = "Alert",
          "This Pokemon is a base pokemon.",
          icon = "thumbs-up",
          status = "success"
        )
      } else {
        # Check that the evolution belongs to the first 151 pkmns ...
        if (evol$id <= 151) {
          tablerTimelineItem(
            title = paste0("Evolves from: ", evol$name),
            status = "green",
            date = NULL,
            img(
              src = if (is_shiny()) {
                poke_data[[evol$id]]$sprites$front_shiny
              } else {
                poke_data[[evol$id]]$sprites$front_default
              }
            )
          )
        } else {
          tablerAlert(
            title = "Alert",
            "This pokemon is an evolution of another pokemon but not
            in the first generation.",
            icon = "thumbs-up",
            status = "success"
          )
        }
      }
    })
  })
}
