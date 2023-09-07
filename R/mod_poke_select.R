#' poke_select UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_poke_select_ui <- function(id) {
  poke_names <- names(poke_data)
  # Extract all pokemon sprites
  poke_sprites <- vapply(
    lapply(poke_data, `[[`, "sprites"),
    `[[`,
    "front_default",
    FUN.VALUE = character(1),
    USE.NAMES = FALSE
  )

  ns <- NS(id)

  # WORKSHOP TODO
  # You may leave this as is or totally change
  # it according to your needs ;)

  fluidRow(
    align = "center",
    bs_icon("hand-index-fill"),
    pickerInput(
      inputId = ns("selected"),
      width = "10%",
      options = list(style = "btn-primary"),
      multiple = FALSE,
      choices = poke_names,
      choicesOpt = list(
        content = sprintf("<img src=\'%s\' width=20 style=\'vertical-align:top;\'></img> %s", poke_sprites, poke_names)
      ),
      selected = poke_names[[1]]
    ),
    # because it's a shiny app ;)
    tagAppendAttributes(
      prettySwitch(
        inputId = ns("is_shiny"),
        label = "Shiny?",
        value = TRUE,
        status = "danger",
        slim = TRUE,
        width = "100%"
      ),
      class = "m-2"
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
    # Add user feedback to select_pokemon (see .R/utils.R)
    selected_pokemon <- eventReactive(input$selected, {
      select_pokemon(input$selected)
    })

    return(
      list(
        selected = selected_pokemon,
        is_shiny = reactive(input$is_shiny)
      )
    )
  })
}
