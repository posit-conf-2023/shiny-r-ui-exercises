#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  ns <- session$ns()

  cancel_btn <- modalButton("cancel")
  cancel_btn <- tagAppendAttributes(
    cancel_btn,
    class = "btn-success"
  )

  observeEvent(TRUE, {
    showModal(
      modalDialog(
        title = "WeLCOME to the PoKeMON APP",
        "Do you want to start the app!",
        size = "s",
        footer = tagList(
          cancel_btn,
          actionButton(
            "continue",
            "Continue",
            class = "btn-danger",
            `data-dismiss` = "modal"
          )
        )
      )
    )
  })

  observeEvent(input$continue, {
    showModal(
      modalDialog(
        title = "The     N1 poKemON APP IN THE WORLD!!!!",
        size = "s",
        "Please confirm",
        footer = tagList(
          modalButton("continue"),
          actionButton(
            "cancel",
            "Cancel",
            class = "btn-success",
            `data-dismiss` = "modal"
          )
        )
      )
    )
  }, priority = 10)

  observeEvent(input$cancel, {
    session$reload()
  })

  main <- mod_poke_select_server("poke_select_1")
  mod_poke_info_server("poke_info_1", main$selected, main$is_shiny)
  mod_poke_type_server("poke_type_1", main$selected)
  mod_poke_evolve_server("poke_evolve_1", main$selected, main$is_shiny)
  mod_poke_stats_server("poke_stats_1", main$selected)
  mod_poke_move_server("poke_move_1", main$selected)
  mod_poke_location_server("poke_location_1", main$selected)
}
