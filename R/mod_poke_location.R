#' poke_location UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_poke_location_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("poke_locations"))
}

#' poke_location Server Functions
#'
#' @param selected Selected pokemon data.
#'
#' @noRd
mod_poke_location_server <- function(id, selected) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$poke_locations <- renderUI({
      req(!is.null(selected()))

      locations <- selected()$locations

      # WORKSHOP TODO
      # Add pokemon locations below. You may check
      # if the pokemon can be seen in the wild as shown below:
      #. if (!is.null(locations)) {
      #.   # Location is a list. You'll have to loop through all
      #.   # of its elements
      #. } else {
      #.   # This pokemon cannot be found in the wild
      #. }
    })
  })
}
