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
mod_poke_info_server <- function(id, selected) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # generate the profile cards (as many as the number of selected pokemons)
    output$poke_infos <- renderUI({
      req(!is.null(selected()))

      pokemon <- selected()

      tagList(
        tags$div(
          class = "left-content",
          tags$div(
            style = "position:relative;",
            tags$img(class = "avatar-icon", src = pokemon$sprites$front_shiny),
            mod_poke_evolve_ui(ns("poke_evolve_1"))
          ),
          tags$div(class = "name", selected()$name),
          tags$div(class = "description", pokemon$description),
          tags$div(
            class = "social-and-pills",
            badge(HTML(sprintf("%s: %s", bs_icon("fingerprint"), pokemon$shape)), "secondary"),
            badge(HTML(sprintf("%s: %s", bs_icon("house"), pokemon$habitat)), "secondary")
          ),
          tags$div(
            class = "info-grid",
            purrr::map(
              other_stats_names(),
              ~ tags$div(
                class = "info-card",
                tags$div(
                  class = "title",
                  purrr::map(
                    unlist(stringr::str_split(.x, "_")),
                    tags$span
                  )
                ),
                tags$p(selected()$other_stats[[.x]])
              )
            )
          )
        )
      )
    })

    mod_poke_stats_server("poke_stats_1", selected)
    mod_poke_evolve_server("poke_evolve_1", selected)
  })
}
