#' poke_move UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_poke_move_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("poke_moves"))
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

      tags$section(
        class="moves",
        tags$h3("Moves"),
        tags$div(class="moves-grid",
        purrr::map(moves,
          ~tags$div(class="move-card",
                   tags$div(class="title", .x$name),
                   tags$p("Power:", .x$power),
                   tags$hr(),
                   tags$p(.x$text)
          )
        ))
      )

    })
  })

}
