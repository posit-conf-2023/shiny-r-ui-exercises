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

        tags$div(
          tags$div(
            "Damages",

          ),
          tags$div(
            "Damages From",

          ),
          tags$div(
            "Damages To",

          )
        )
        damage_table <- tags$table(
          tags$tr(
            tags$th("Damages"),
            tags$th("Damages From"),
            tags$th("Damages To")
          ),
          tags$tr(
            tags$td(span(class="n", "2X")),
            tags$td(
              purrr::map(double_damage_from,
                         ~tags$span(.x, class="pill tag tag-rounded",)
                         )
              ),
            tags$td(
              purrr::map(double_damage_to, ~tags$span(.x, class="pill tag tag-rounded"))
            )
          ),
          tags$tr(
            tags$td(span(class="n", "0.5X")),
            tags$td(
              purrr::map(half_damage_from, ~tags$span(.x, class="pill tag tag-rounded"))
            ),
            tags$td(
              purrr::map(half_damage_to, ~tags$span(.x, class="pill tag tag-rounded"))
            )
          ),
          tags$tr(
            tags$td(class="n", "0"),
            tags$td(
              purrr::map(no_damage_from,
                         ~tags$span(.x,
                                    class="pill tag tag-rounded",
                         )
              )
            ),
            tags$td(
              purrr::map(no_damage_to,
                         ~tags$span(.x,
                                    class="pill tag tag-rounded",
                         )
              )
            )
          )
        )

        tags$div(class="type-card",
                 tags$span(class="title", type_name),
                 damage_table
        )

      })

    })
  })
}
