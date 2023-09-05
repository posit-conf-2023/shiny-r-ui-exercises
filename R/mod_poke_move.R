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

      tablerCard(
        title = paste0(selected()$name, " Moves"),
        statusSide = "top",
        collapsible = FALSE,
        closable = FALSE,
        zoomable = FALSE,
        width = 12,

        # card content
        lapply(seq_along(moves), FUN = function(i) {
          move_name <- moves[[i]]$name
          move_pp <- moves[[i]]$pp
          move_priority <- moves[[i]]$priority
          move_type <- moves[[i]]$type
          move_power <- moves[[i]]$power
          move_accuracy <- moves[[i]]$accuracy
          move_text <- moves[[i]]$text

          fluidRow(
            paste("Move: ", move_name),
            tagAppendAttributes(
              tablerTag(
                paste("Power:", move_power),
                href = NULL,
                rounded = FALSE,
                color = NULL
              ),
              class = "mx-2"
            ),
            move_text
          )
        })
      )
    })
  })
}
