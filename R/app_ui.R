#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # WORKSHOP TO DO
    # Organize the UI modules here in the layout
    # you draw during the wireframing part:

    # - mod_poke_info_ui("poke_info_1")
    # - mod_poke_type_ui("poke_type_1")
    # - mod_poke_evolve_ui("poke_evolve_1")
    # - mod_poke_stats_ui("poke_stats_1")
    # - mod_poke_move_ui("poke_move_1")
    # - mod_poke_location_ui("poke_location_1")

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
    # WORKSHOP TODO
    # Put any custom CSS and JS or font here.
    # Note that when elements are in the www folder,
    # there is no need to put them here because of
    # bundle_resources above.

  )
}
