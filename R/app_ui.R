#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @noRd
app_ui <- function(request) {

  nav_tag <- tablerDashNav(
    id = "mymenu",
    src = "https://www.ssbwiki.com/images/9/9c/Master_Ball_Origin.png",
    mod_poke_select_ui("poke_select_1")
  )

  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    tablerDashPage(
      navbar = nav_tag,
      title = "Gotta Catch'Em (Almost) All",
      body = tablerDashBody(
        tags$div(class="background-banner"),
         tags$section(class="section-body",
          tags$div(class="left",
              mod_poke_info_ui("poke_info_1")
          ),
          tags$div(class="right",
            tags$div(class="right-grid",
                     bslib::layout_column_wrap(
                       width = NULL,
                       height = 388,
                       mod_poke_stats_ui("poke_stats_1"),
                       mod_poke_location_ui("poke_location_1")
                     )
            )
          )
        ),
        # style = "background-color: brown",
        mod_poke_type_ui("poke_type_1"),
        mod_poke_move_ui("poke_move_1")
      ),
      footer = tablerDashFooter(
        copyrights = "Disclaimer: this app is purely intended for learning purpose. @David Granjon, 2023"
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
    ),
    # custom font setup
    tags$link(
      href = "https://fonts.googleapis.com/css?family=Press+Start+2P",
      rel = "stylesheet"
    ),
    # tags$style(
    #  "html, body, pre, code, kbd, samp {
    #      font-family: 'Press Start 2P';
    #  }"
    # )
  )
}
