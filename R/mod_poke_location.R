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
  uiOutput(ns("poke_locations"), class = "col-sm-6")
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

      tablerCard(
        title = paste0("where to find ", selected()$name, " ?"),
        collapsible = FALSE,
        closable = FALSE,
        zoomable = FALSE,
        statusSide = "top",
        width = 12,
        if (!is.null(locations)) {
          lapply(seq_along(locations), function(i) {
            if (!is.null(locations[[i]])) {
              fluidRow(paste(i, ":", locations[[i]]))
            }
          })
        } else {
          "This pokemon cannot be found in the wild."
        }
      )
    })
  })
}
