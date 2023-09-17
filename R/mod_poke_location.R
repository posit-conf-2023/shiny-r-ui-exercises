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

      if (is.null(locations)) {
        location_content <- "This pokemon cannot be found in the wild."
      } else {
        location_content <-  list_group(locations)
      }
      tagList(
        tags$div(
          class = "d-flex justify-content-center mt-4",
          HTML(
            sprintf(
              "Location %s",
              bslib::tooltip(
                tags$sup(bs_icon("patch-question", size = "1em")),
                "The Pokemon map is organized between roads, cities and locations.
                This indicates where to find the pokemon."
              )
            )
          )
        ),
        location_content
      )
    })

  })
}
