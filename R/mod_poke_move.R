#' poke_move UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_poke_move_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("poke_moves"), class = "col-sm-12")
}

#' poke_move Server Functions
#' @param selected Selected pokemon data.
#'
#' @noRd
mod_poke_move_server <- function(id, selected) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # generate the card
    output$poke_moves <- renderPrint({
      req(!is.null(selected()))

      moves <- selected()$moves

      # WORKSHOP TODO
      # Process pokemon moves. This is a list so you
      # can leverage lapply to treat each move:
      # lapply(seq_along(moves), FUN = function(i) {
      #   # Process each move ...
      # })
    })
  })
}
