#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  main <- mod_poke_select_server("poke_select_1")
  mod_poke_info_server("poke_info_1", main$selected, main$is_shiny)
  mod_poke_type_server("poke_type_1", main$selected)
  mod_poke_evolve_server("poke_evolve_1", main$selected, main$is_shiny)
  mod_poke_stats_server("poke_stats_1", main$selected)
  mod_poke_move_server("poke_move_1", main$selected)
  mod_poke_location_server("poke_location_1", main$selected)
}
