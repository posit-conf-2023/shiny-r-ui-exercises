#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    tablerDashPage(
      navbar = tablerDashNav(
        id = "mymenu",
        src = "https://www.ssbwiki.com/images/9/9c/Master_Ball_Origin.png",
        navMenu = tablerNavMenu(
          tablerNavMenuItem(
            tabName = "PokeInfo",
            icon = "home",
            "PokeInfo"
          )
        ),
        # Select input UI module
        mod_poke_select_ui("poke_select_1"),
        tablerDropdown(
          tablerDropdownItem(
            title = NULL,
            href = "https://pokeapi.co",
            url = "https://pokeapi.co/static/logo-6221638601ef7fa7c835eae08ef67a16.png",
            status = "success",
            date = NULL,
            "This app use pokeApi by Paul Hallet and PokéAPI contributors."
          )
        )
      ),
      footer = tablerDashFooter(
        copyrights = "Disclaimer: this app is purely intended for learning purpose. @David Granjon, 2023"
      ),
      title = "Gotta Catch'Em (Almost) All",
      body = tablerDashBody(
        tablerTabItems(
          tablerTabItem(
            tabName = "PokeInfo",
            fluidRow(
              column(
                width = 4,
                mod_poke_info_ui("poke_info_1"),
                mod_poke_type_ui("poke_type_1"),
                mod_poke_evolve_ui("poke_evolve_1")
              ),
              column(
                width = 8,
                mod_poke_stats_ui("poke_stats_1"),
                mod_poke_move_ui("poke_move_1"),
                mod_poke_location_ui("poke_location_1")
              )
            )
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "shinyMons2"
    )
  )
}
