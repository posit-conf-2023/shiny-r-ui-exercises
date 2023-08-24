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

    # Programmatically generate stat cards
    lapply(other_stats_names(), function(stat) {
      output[[stat]] <- renderUI({
        req(input$poke_basic_stats)
        val <- selected()$other_stats[[stat]]

        tablerStatCard(
          value = val,
          title = stat,
          width = 12
        )
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

      tablerCard(
        title = paste0(selected()$name, " Stats"),
        options = tagList(
          prettySwitch(
            inputId = ns("poke_basic_stats"),
            label = "Display Basic Stats?",
            value = TRUE,
            status = "default",
            slim = TRUE,
            fill = FALSE,
            bigger = TRUE,
            inline = FALSE
          )
        ),
        footer = sprintf("Sum of stats: %s (Mew is 500)", selected()$sum_stats),
        status = "info",
        statusSide = "left",
        collapsible = FALSE,
        closable = FALSE,
        zoomable = FALSE,
        width = 12,
        overflow = FALSE,
        echarts4rOutput(outputId = ns("poke_stats"))
      )
    })
  })
}
