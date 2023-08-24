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
          move_slot <- moves[[i]]$moveSlot
          move_effect <- moves[[i]]$moveEffect
          move_id <- moves[[i]]$id

          fluidRow(
            paste("Slot: ", move_slot),
            tagAppendAttributes(
              tablerTag(
                paste(move_id, move_name),
                href = NULL,
                rounded = FALSE,
                color = NULL
              ),
              class = "mx-2"
            ),
            move_effect
          )
        })
      )
    })
  })
}
