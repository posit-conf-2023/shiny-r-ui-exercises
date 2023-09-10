#' poke_move UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_poke_move_ui <- function(id) {
  ns <- NS(id)
  tags$section(class="moves",
    h3("Moves"),
    reactable::reactableOutput(ns("poke_moves"))
  )
}

#' poke_move Server Functions
#' @param selected Selected pokemon data.
#'
#' @noRd
mod_poke_move_server <- function(id, selected) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    # generate the card
    output$poke_moves <- reactable::renderReactable({
      req(!is.null(selected()))
      moves <- selected()$moves

      move_df <- data.frame(
        name = purrr::map(moves, `[`, 'name') |> unlist(),
        power = purrr::map(moves, `[`, 'power') |> unlist(),
        text = purrr::map(moves, `[`, 'text') |> unlist()
      )

      bar_chart <- function(label, width = "100%", height = "100%", fill = "#00bfc4", background = NULL) {

        if (width == "0px") {
          return(div(
            style = list(
              alignItems = "center",
              background = background,
              padding = "3px",
              `font-size`= "0.75rem"),
            label)
          )
        }

        bar <- div(style = list(background = fill, display = 'flex', width = width, height = height, padding = "3px"), label)
        chart <- div(style = list(
          flexGrow = 1,
          `font-size`= "0.75rem",
          color="white",
          background = background),
          bar
        )
        div(style = list(alignItems = "center"), chart)
      }

      reactable::reactable(
        move_df |> dplyr::arrange(-power),
        height = 270,
        pagination = FALSE,
        columns = list(
          name = reactable::colDef(name = "Move", width = 150, cell = function(value) { tags$strong(value)} ),
          text = reactable::colDef(name = "Details"),
          power = reactable::colDef(name = "Power", width = 150, align = "left", cell = function(value) {
          width <- ifelse(is.na(value), "0px", paste0(value / max(move_df$power, na.rm = TRUE) * 100, "%"))
          bar_chart(value, width = width, fill = "#393D47", background = "#e1e1e1")
        })
        )
      )

    })

  })

}
