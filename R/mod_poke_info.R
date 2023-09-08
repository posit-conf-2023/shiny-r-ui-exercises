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
        tags$div(class="left-content",
            tags$div(style="position:relative;",
              tags$img(class="avatar-icon", src=pokemon$sprites$front_shiny),
              mod_poke_evolve_ui(ns("poke_evolve_1"))
            ),
            tags$div(class="name", selected()$name),
            tags$div(class="description", pokemon$description),
            tags$div(class="social-and-pills",
            tablerTagList(
              align = "center",
              tablerTag(name = pokemon$shape, rounded = TRUE, color = "default"),
              tablerTag(name = pokemon$habitat, rounded = TRUE, color = ifelse(pokemon$color == "white", 'offwhite', pokemon$color))
            ),
            tablerSocialLinks(
              tablerSocialLink(
                name = "pokeApi",
                href = paste0("https://pokeapi.co/api/v2/pokemon/", tolower(selected())),
                icon = "at"
              ),
              tablerSocialLink(
                name = "Bulbapedia",
                href = paste0("https://bulbapedia.bulbagarden.net/wiki/", selected(), "_(Pok\u00e9mon)"),
                icon = "address-card"
              )
            )),
            tags$div(class="info-grid",
              purrr::map(
                other_stats_names(),
                ~tags$div(
                  class="info-card",
                  tags$div(class="title",
                           purrr::map(
                             unlist(stringr::str_split(.x, "_")),
                             tags$span
                          )
                  ),
                  tags$p(selected()$other_stats[[.x]])
                )
              ),
              tags$div(
                mod_poke_type_ui(ns("poke_type_1"))
              )
            )
        )
      )
    })

    mod_poke_stats_server("poke_stats_1", selected)
    mod_poke_evolve_server("poke_evolve_1", selected)

  })
}
