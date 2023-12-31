## code to prepare `pokeapi_data` dataset goes here
# # Run this script to rebuild a clean pokemon file
library(dplyr)
library(parallel)
library(jsonlite)

poke_ids <- 1:151
# create the pokemon object
poke_api <- "https://pokeapi.co/api/v2/pokemon/"
# There are locations not related to the first generation so
# we need some filtering...
kanto_locations <- fromJSON("https://pokeapi.co/api/v2/region/1")$locations$name

english_language <- function(l) {
  which(
    extra_from_list(lapply(l, `[[`, "language")) == "en"
  )[[1]]
}

poke_data <- mclapply(seq_along(poke_ids), FUN = function(i) {
  tmp <- fromJSON(sprintf("%s/%s", poke_api, i), simplifyVector = FALSE)
  details <- fromJSON(tmp$species$url, simplifyVector = FALSE)

  # Extract English language
  lang_idx <- english_language(details$flavor_text_entries)

  locations <- fromJSON(tmp$location_area_encounters, simplifyVector = FALSE)
  # we could dive into location$version_details to get
  # the encounter method, percentage of chance, ...
  if (length(locations) > 0) {
    locations <- dropNulls(
      lapply(locations, function(loc) {
        loc_data <- fromJSON(loc$location_area$url)
        # For some reasons, the API creators decided
        # that location area and location are not the same
        # so we have to call another round of fromJSON which
        # is crazy slow ...
        tmp_name <- loc_data$location$name
        if (tmp_name %in% kanto_locations) tmp_name
      })
    )
  } else {
    locations <- c()
  }

  evolves_from <- if (is.null(details$evolves_from_species$name)) {
    list()
  } else {
    # TO DO: add level, trigger, ...nolint start: commented_code_linter.
    # evol_details <- fromJSON(
    #  details$evolution_chain$url,
    #. simplifyVector = FALSE
    # ) nolint end
    list(
      name = details$evolves_from_species$name,
      id = as.numeric(
        tail(
          strsplit(details$evolves_from_species$url, "/")[[1]],
          n = 1
        )
      )
    )
  }

  sum_stats <- sum(vapply(tmp$stats, `[[`, "base_stat", FUN.VALUE = numeric(1)))

  # Process stats: don't include stat url
  tmp$stats <- lapply(tmp$stats, function(stat) {
    stat$name <- stat$stat$name
    stat$stat <- NULL
    stat
  })

  # Process types: extend by API values
  tmp$types <- dropNulls(
    lapply(tmp$types, function(type) {
      data <- fromJSON(type$type$url, simplifyVector = FALSE)
      if (data$generation$name == "generation-i") {
        type$name <- type$type$name
        type$type <- NULL
        type$damage_relations <- data$damage_relations
        type
      }
    })
  )

  # Process moves (can be super slow)
  tmp$moves <- dropNulls(
    lapply(tmp$moves, function(move) {
      first_gen <- vapply(move$version_group_details, function(d) {
        grepl("(red|blue|yellow)", d$version_group$name)
      }, FUN.VALUE = logical(1))

      # Don't proceed if does not exist in first gen
      if (sum(first_gen) > 0) {
        data <- fromJSON(move$move$url, simplifyVector = FALSE)
        move$name <- data$name
        # Hopefully flavor_text_entries > 0 ?? ;)
        move$text <- data$effect_entries[[1]]$effect
        move$move <- NULL
        move$version_group_details <- NULL
        move$pp <- data$pp
        move$priority <- data$priority
        move$type <- data$type$name
        move$power <- if (length(data$power) > 0) data$power else NA
        move$accuracy <- if (length(data$accuracy) > 0) data$accuracy else NA
        move
      }
    })
  )

  # Aggregate data in one big list ...
  list(
    name = tmp$species$name,
    description = details$flavor_text_entries[[lang_idx]]$flavor_text,
    shape = details$shape$name,
    sprites = list(
      front_default = tmp$sprites$front_default,
      front_shiny = tmp$sprites$front_shiny
    ),
    habitat = details$habitat$name,
    color = details$color$name,
    stats = tmp$stats,
    other_stats = list(
      height = sprintf("%s cm", tmp$height * 10), # cm
      weight = sprintf("%s Kg", tmp$weight / 10), # Kg
      base_happiness = details$base_happiness,
      capture_rate = sprintf("%s/255", details$capture_rate),
      growth_rate = details$growth_rate$name
    ),
    sum_stats = sum_stats, # Sum of base stats. Mew is 500 ...
    moves = tmp$moves,
    types = tmp$types,
    locations = locations,
    evolve_from = evolves_from,
    is_lengendary = details$is_legendary, # Mewtho, Artikodin, ...
    is_mythical = details$is_mythical # Mew
  )
})
poke_names <- vapply(poke_data, `[[`, "name", FUN.VALUE = character(1))
names(poke_data) <- poke_names
usethis::use_data(poke_data, overwrite = TRUE)

# To view data
library(listviewer)
jsonedit(poke_data[[1]])
