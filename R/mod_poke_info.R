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
mod_poke_info_server <- function(id, selected, is_shiny) {
  moduleServer(id, function(input, output, session) {

    # generate the profile cards (as many as the number of selected pokemons)
    output$poke_infos <- renderUI({
      req(!is.null(selected()))

      pokemon <- selected()

      tagList(
        fluidRow(
          tablerCard(
            tablerProfileCard(
              title = selected()$name,
              subtitle = tagList(
                pokemon$description,
                tablerTagList(
                  align = "center",
                  tablerTag(name = pokemon$shape, rounded = TRUE, color = "default"),
                  tablerTag(name = pokemon$habitat, rounded = TRUE, color = pokemon$color)
                )
              ),
              background = "https://images.pexels.com/photos/355748/pexels-photo-355748.jpeg",
              src = if (!is_shiny()) {
                pokemon$sprites$front_default
              } else {
                pokemon$sprites$front_shiny
              },
              socials = tablerSocialLinks(
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
              ),
              width = 4
            )
          )
        ),
        br()
      )
    })
  })
}
