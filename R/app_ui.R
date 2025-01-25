#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @noRd
#' @import waiter
app_ui <- function(request) {

  #nav_tag <- tablerDashNav(
  #  id = "mymenu",
  #  src = "https://www.ssbwiki.com/images/9/9c/Master_Ball_Origin.png",
  #  mod_poke_select_ui("poke_select_1")
  #)

  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    waiter::waiterPreloader(
      html = tagList(
        tags$div(class="pokeball",
          tags$div(class="pokeball__button")
        ),
        "Loading ..."
      )
    ),
    bslib::page_fluid(
      title = "PokeApp",
      br(),
      jumbotron("Gotta Catch'Em (Almost) All"),
      tags$div(class = "d-flex justify-content-center my-5", mod_poke_select_ui("poke_select_1")),

      bslib::layout_columns(
        col_widths = c(4, 8),
        bslib::layout_columns(
          width = 1,
          mod_poke_info_ui("poke_info_1"),
          mod_poke_location_ui("poke_location_1")
        ),
        mod_poke_stats_ui("poke_stats_1")
      ),

      #tags$section(
      #  class = "section-body",
      #  tags$div(
      #    class = "left",
      #    mod_poke_info_ui("poke_info_1"),
      #    mod_poke_location_ui("poke_location_1")
      #  ),
      #  tags$div(class="right", mod_poke_stats_ui("poke_stats_1"))
      #),
      # style = "background-color: brown",
      mod_poke_move_ui("poke_move_1"),
      mod_poke_type_ui("poke_type_1"),
      footer = "Disclaimer: this app is purely intended for learning purpose. @David Granjon, 2023"
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
    ),
    # Screen loader
    waiter::useWaiter()
  )
}
