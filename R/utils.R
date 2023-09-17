#' Set up colors according to the pokemon type
#'
#' @param type Pokemon type.
#'
#' @return A color, string.
#' @keywords internal
get_type_colors <- function(type) {
  switch(type,
    "normal" = "lightgray",
    "fighting" = "#F98D80",
    "flying" = "#BD9FFC",
    "poison" = "#CBC3E3",
    "ground" = "#FFFFED",
    "rock" = "#FDDA0D",
    "bug" = "#AEF1BD",
    "ghost" = "#BD9FFC",
    "fire" = "orange",
    "water" = "#B3DFF8",
    "grass" = "#1EE80A",
    "electric" = "yellow",
    "psychic" = "#FF9AD0",
    "ice" = "#C5FAF8",
    "dragon" = "#BD9FFC"
  )
}

#' Stats names are all the same for any pokemon ...
#'
#' @return A vector of stat names.
#' @keywords internal
other_stats_names <- function() {
  names(poke_data[[1]]$other_stats)
}

#' Remove NULL elements from list
#'
#' @param x List to cleanup
#'
#' @return A list.
#' @keywords internal
dropNulls <- function(x) { #nolint
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

#' Extract selected key from lists
#'
#' @param l List to search in.
#' @param key List key to extract. Default to name.
#' @param type Needed by \code{vapply} as FUN.VALUE parameter.
#' Default to character.
#'
#' @return A list.
#' @keywords internal
extra_from_list <- function(l, key = "name", type = character(1)) {
  vapply(
    l,
    `[[`,
    key,
    FUN.VALUE = type
  )
}

#' Get max of each stat
#'
#' Loop over poke_data and get the max of each stat.
#'
#' @param stat Optional stat column to select.
#'
#' @return If stat is NULL, a 1 row tibble is returned containing
#' the max of each stat among all pokemons. If a stat is specified,
#' a numeric value is returned instead.
#' @keywords internal
get_max_stats <- function(stat = NULL) {
  res <- lapply(
    poke_data,
    function(data) {
      stats <- data$stats
      tmp <- extra_from_list(
        stats,
        "base_stat",
        numeric(1)
      )
      names(tmp) <- extra_from_list(stats)
      tmp
    }
  )

  # Merge lists into tibble
  res <- do.call(rbind, res) |>
    as_tibble()
  if (is.null(stat)) res else pull(res, stat)
}

#' Get max of all stats maxes
#'
#' Needed by \link{create_radar_stats} to get the max
#' of the radar chart axis.
#'
#' @param data Returned by \link{get_max_stats} with stat
#' set to NULL.
#'
#' @return A numeric value.
#' @keywords internal.
get_max_of_max <- function(data = get_max_stats()) {
  cols <- colnames(data)
  data |>
    # get max of each stat
    summarise(across(all_of(cols), max)) |>
    rowwise() |>
    # Max of max
    max()
}

#' Create radar chart for selected pokemon
#'
#' @param pokemon The selected pokemon data.
#'
#' @return A chart htmlwidget.
#' @export
create_radar_stats <- function(pokemon) {
  # R CMD check stop crying ...
  x <- y <- z <- NULL

  stats <- pokemon$stats
  # Prepare data
  data <- process_pokemon_stats(stats)

  # Also adds previous pokemon stats to compare
  # Check that the evolution belongs to the first 151 pkmns ...
  if (length(pokemon$evolve_from) > 0 && pokemon$evolve_from$id <= 151) {
    tmp <- process_pokemon_stats(
      poke_data[[pokemon$evolve_from$name]]$stats
    )
    data$z <- tmp$y
    data |>
      e_charts(x) |>
      e_radar(
        y,
        name = paste0(pokemon$name, " Stats"),
        max = get_max_of_max()
      ) |>
      e_radar(z, name = paste0(pokemon$evolve_from$name, " Stats")) |>
      e_color(c('#393D47', '#BBBBBB')) |>
      e_tooltip(trigger = "item")
  } else {
    data |>
      e_charts(x) |>
      e_radar(y, name = paste0(pokemon$name, " Stats"), max = get_max_of_max()) |>
      e_tooltip(trigger = "item") |>
      e_color('#393D47')
  }
}

#' Internal function needed by \link{create_radar_stats}.
#'
#' Rearrange stats for echart4r...
#'
#' @param stats List of stats from selected pokemon.
#'
#' @return A dataframe.
#' @keywords internal
process_pokemon_stats <- function(stats) {
  data.frame(
    x = extra_from_list(stats),
    y = extra_from_list(stats, "base_stat", numeric(1))
  )
}

#' Function to select pokemon
#'
#' Select pokemon in the \link{poke_data}.
#'
#' @param selected Selected pokemon name.
#'
#' @return A list containing the selected pokemon data.
#' @keywords internal
select_pokemon <- function(selected) {
  # We make the function slow on purpose.

  # WORKSHOP TODO
  # Find a way to warn the user about this waiting time ...
  Sys.sleep(5)

  # We simulate an imaginary failing API connection
  # This randomly fails so the function result
  # isn't predictable...and the app crashes without
  # notifying the user of what happened...

  # WORKSHOP TODO
  # Find a way to make this function elegantly failing
  # and warn the end user ...
  res <- sample(c(FALSE, TRUE), 1)
  if (!res) {
    stop("Could not connect to the Pokemon API ...")
  } else {
    poke_data[[selected]]
  }
}

badge <- function(text, color) {
  tags$span(
    class = sprintf("badge rounded-pill text-bg-%s", color),
    text
  )
}

jumbotron <- function(title, ...) {
  tags$div(
    class = "p-5 mt-1 mb-4 bg-secondary rounded-3",
    tags$div(
      class = "container-fluid py-5",
      tags$h1(class = "display-5 fw-bold", title),
      ...
    )
  )
}

list_group <- function(...) {
  items <- c(...)
  tags$ol(
    class = "list-group list-group-numbered",
    lapply(items, tags$li, class = "list-group-item")
  )
}

# R CMD check ...
globalVariables("poke_data")

