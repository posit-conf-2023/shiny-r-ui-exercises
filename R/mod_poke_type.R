#' poke_type UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_poke_type_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("poke_types"))
}

#' poke_type Server Functions
#' @param selected Selected pokemon data.
#'
#' @noRd
mod_poke_type_server <- function(id, selected) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # render infoBoxes
    output$poke_types <- renderUI({
      req(!is.null(selected()))

      types <- selected()$types

      # WORKSHOP TODO
      # types is a list so you can use the below code
      # to generate the corresponding UI:

      # lapply(seq_along(types), FUN = function(i) {
      #   type_name <- types[[i]]$name
      #   type_slot <- types[[i]]$slot
      #
      #   # Tip: damage relation is a deeply nested list.
      #   # Elements are extracted below with extra_from_list ...
      #   damage_relations <- types[[i]]$damage_relations
      #
      #   double_damage_from <- extra_from_list(
      #     damage_relations$double_damage_from
      #   )
      #   double_damage_to <- extra_from_list(
      #     damage_relations$double_damage_to
      #   )
      #   half_damage_from <- extra_from_list(
      #     damage_relations$half_damage_from
      #   )
      #   half_damage_to <- extra_from_list(
      #     damage_relations$half_damage_to
      #   )
      #   no_damage_from <- extra_from_list(
      #     damage_relations$no_damage_from
      #   )
      #   no_damage_to <- extra_from_list(
      #     damage_relations$no_damage_to
      #   )
      #
      #   # Map the color according to the type name
      #   poke_color <- get_type_colors(type_name)
      # })
    })
  })
}
