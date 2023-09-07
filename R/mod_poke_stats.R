#' poke_stats UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_poke_stats_ui <- function(id) {
  ns <- NS(id)
  tagList(
    lapply(other_stats_names(), function(stat) {
      uiOutput(ns(stat))
    }),
    uiOutput(ns("poke_stats_card"))
  )
}

#' poke_stats Server Functions
#'
#' @param selected Selected pokemon data.
#'
#' @noRd
mod_poke_stats_server <- function(id, selected) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # Programmatically generate stat cards.
    # other_stats_names is not reactive and available
    # to the package developer.
    lapply(other_stats_names(), function(stat) {
      output[[stat]] <- renderUI({
        req(input$poke_basic_stats)
        val <- selected()$other_stats[[stat]]

        # WORKSHOP TO DO
        # Add UI for optional stat elements
      })
    })

    # Generate radar chart for pokemons
    output$poke_stats <- renderEcharts4r({
      req(!is.null(selected()))
      create_radar_stats(selected())
    })

    # card wrapper for the charts
    output$poke_stats_card <- renderUI({
      req(!is.null(selected()))

      # WORKSHOP TODO
      # Add the stat main ui including the radar chart output above:
      # echarts4rOutput(outputId = ns("poke_stats"))
    })
  })
}
