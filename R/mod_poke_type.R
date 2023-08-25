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

        tagList(
          tablerInfoCard(
            value = paste(type_slot, type_name),
            status = poke_color,
            icon = icon("card"),
            description = "%",
            width = 12
          ),
          fluidRow(
            column(
              width = 10,
              align = "left",
              h5("Damages from:"), br(),
              HTML(paste0(tablerTag(name = "2X", rounded = FALSE, color = "red"), " ")),
              lapply(seq_along(double_damage_from), FUN = function(j) double_damage_from[[j]]), br(),
              HTML(paste0(tablerTag(name = "0.5X", rounded = FALSE, color = "green"), " ")),
              lapply(seq_along(half_damage_from), FUN = function(j) half_damage_from[[j]]), br(),
              HTML(paste0(tablerTag(name = "0", rounded = FALSE, color = "default"), " ")),
              lapply(seq_along(no_damage_from), FUN = function(j) no_damage_from[[j]])
            ),
            column(
              width = 2,
              align = "left",
              h5("Damages to:"), br(),
              HTML(paste0(tablerTag(name = "2X", rounded = FALSE, color = "green"), " ")),
              lapply(seq_along(double_damage_to), FUN = function(j) double_damage_to[[j]]), br(),
              HTML(paste0(tablerTag(name = "0.5X", rounded = FALSE, color = "red"), " ")),
              lapply(seq_along(half_damage_to), FUN = function(j) half_damage_to[[j]]), br(),
              HTML(paste0(tablerTag(name = "0", rounded = FALSE, color = "default"), " ")),
              lapply(seq_along(no_damage_to), FUN = function(j) no_damage_to[[j]])
            )
          ),
          br()
        )
      })
    })
  })
}
