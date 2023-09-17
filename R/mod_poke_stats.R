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

    # Generate radar chart for pokemons
    output$poke_stats <- renderEcharts4r({
      req(!is.null(selected()))
      create_radar_stats(selected())
    })

    # card wrapper for the charts
    output$poke_stats_card <- renderUI({
      req(!is.null(selected()))
      bslib::card(
        bslib::card_header(
          HTML(
            sprintf(
              "%s Statistics %s",
              bs_icon("graph-up"),
              bslib::tooltip(
                tags$sup(bs_icon("patch-question", size = "1em")),
                "A Pokemon has 5 main stats. Mew has 100 for each stat. The maximum for each stat
                is 255. The higher the sum, the better is the Pokemon."
              )
            )
          )
        ),
        bslib::card_body(echarts4rOutput(outputId = ns("poke_stats"))),
        bslib::card_footer(sprintf("Sum of stats: %s (Mew is 500)", selected()$sum_stats))
      )
    })

  })
}
