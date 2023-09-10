#' poke_type UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_poke_type_ui <- function(id) {
  ns <- NS(id)
  tags$section(class="moves",
    h3("Type"),
    uiOutput(ns("poke_types"))
  )
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

      lapply(seq_along(types), FUN = function(i) {
        type_name <- types[[i]]$name
        type_slot <- types[[i]]$slot

        damage_relations <- types[[i]]$damage_relations

        double_damage_from <- extra_from_list(
          damage_relations$double_damage_from
        )
        double_damage_to <- extra_from_list(
          damage_relations$double_damage_to
        )
        half_damage_from <- extra_from_list(
          damage_relations$half_damage_from
        )
        half_damage_to <- extra_from_list(
          damage_relations$half_damage_to
        )
        no_damage_from <- extra_from_list(
          damage_relations$no_damage_from
        )
        no_damage_to <- extra_from_list(
          damage_relations$no_damage_to
        )

        poke_color <- get_type_colors(type_name)

        damage_table <- tags$table(
          tags$tr(
            tags$th("Damages From"),
            tags$th("Damaages To")
          ),
          tags$tr(
            tags$td(class="flex-table-row",
              span(class="n", style = "background:red;", "2X"),
              lapply(seq_along(double_damage_from), FUN = function(j) double_damage_from[[j]])
            ),
            tags$td(class="flex-table-row",
              span(class="n", style = "background:green;", "2X"),
              lapply(seq_along(double_damage_to), FUN = function(j) double_damage_to[[j]])
            ),
          ),
          tags$tr(
            tags$td(class="flex-table-row",
              span(class="n", style = "background:green;", "0.5X"),
              lapply(seq_along(half_damage_from), FUN = function(j) half_damage_from[[j]])
            ),
            tags$td(class="flex-table-row",
              span(class="n", style = "background:red;", "0.5X"),
              lapply(seq_along(half_damage_to), FUN = function(j) half_damage_to[[j]])
            ),
          ),
          tags$tr(
            tags$td(class="flex-table-row",
              span(class="n", style = "background:gray", "0"),
              lapply(seq_along(no_damage_from), FUN = function(j) no_damage_from[[j]])
            ),
            tags$td(class="flex-table-row",
              span(class="n", style = "background:gray;", "0"),
              lapply(seq_along(no_damage_to), FUN = function(j) no_damage_to[[j]])
            ),
          ),
        )

        tags$div(class="type-card",
                 tags$span(class="title", type_name),
                 damage_table
        )

      })

    })
  })
}
