#' poke_select UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_poke_select_ui <- function(id) {
  poke_names <- names(poke_data)
  poke_sprites <- vapply(
    lapply(poke_data, `[[`, "sprites"),
    `[[`,
    "front_default",
    FUN.VALUE = character(1),
    USE.NAMES = FALSE
  )

  ns <- NS(id)
  fluidRow(
    align = "center",
    pickerInput(
      inputId = ns("selected"),
      options = list(style = "btn-secondary form-select-lg"),
      multiple = FALSE,
      choices = poke_names,
      choicesOpt = list(
        content = sprintf("<img src=\'%s\' width=20 style=\'vertical-align:top;\'></img> %s", poke_sprites, poke_names)
      ),
      selected = poke_names[[1]]
    )
  )
}

#' poke_select Server Functions
#'
#' @noRd
mod_poke_select_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # WORKSHOP TODO
    # Add user feedback to select_pokemon
    selected_pokemon <- eventReactive(input$selected, {
      select_pokemon(input$selected)
    })

    return(
      list(
        selected = selected_pokemon,
        is_shiny = reactive(TRUE)
      )
    )
  })
}
