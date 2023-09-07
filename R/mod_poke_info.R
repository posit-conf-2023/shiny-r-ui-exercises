#' poke_info UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_poke_info_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("poke_infos"))
}

#' poke_info Server Functions
#'
#' @param selected Selected pokemon data.
#' @param is_shiny Is the pokemon in shiny form? Boolean.
#'
#' @noRd
mod_poke_info_server <- function(id, selected, is_shiny) {
  moduleServer(id, function(input, output, session) {

    # generate the profile cards (as many as the number of selected pokemons)
    output$poke_infos <- renderUI({
      req(!is.null(selected()))

      pokemon <- selected()

      # WORKSHOP TODO
      # Add the UI containing general information
      # about the selected Pokemon.
      # Note (optional): sprites data have 2 entries so you may want
      # to check if the pokemon is under its Shiny form like
      # below:
      # if (!is_shiny()) {
      #   pokemon$sprites$front_default
      # } else {
      #   pokemon$sprites$front_shiny
      # }

    })
  })
}
