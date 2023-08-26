
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shinyMons2

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Goal: shinyMons2 is a pokemon app displaying information related to the
151 first pokemons (first gen). Your mission, should you accept it, will
be to redesign this app currently suffering from some UX issues,
following the best practices learnt during our workshop. Fear not! We’ll
proceed step by step…

This project is hosted on Posit Cloud in this
[space](https://posit.cloud/spaces/400773/join?access_code=ajwkws91bhF-IhEXDVWH9-0mukSUF3jiETCkzrgt)
and deployed [here](https://dgranjon.shinyapps.io/shinyMonsUgly).

## Work instructions

Each one of you will be working in a group, an ID will be assigned to
you prior to the workshop. Therefore, only one person/group will have to
commit the code to GitHub. Group leads will be randomly assigned prior
to the workshop and communicated to you.

1.  Create a new branch named `<group_ID>` (1 per group!).
2.  Run `renv::restore()`.
3.  Ready to start?

Please remember that you can run `styler::style_pkg()` and
`devtools::lint()` so the code style stays consistent.

### Part 1 Layout

- Wireframing.
- bslib layout.

### Part 2 colors and typo

- bslib color palette.
- Contrasts tuning.
- Dark/light mode?

### Part 3 interactions

- Sanitize failing functions.
- Handle slow functions.
- Better help messages.

## App structure

This app leveraging `{golem}` is composed of 6 modules. The main module
is `mod_poke_select`, which returns the selected pokemon (picker input)
as well as its variant (shiny or not). Those data are passed to other
modules. General pokemon data, namely `poke_data`, have been
pre-processed for you so you don’t have to focus on the data wrangling
but the UI design (This also avoids us to flood the underlying API with
too many requests).

If you’re more curious, browse to `inst/doc` and have a look to:

- `data-doc.html`: htmlwidget showing the data structure for the first
  pokemon, so you get an idea on what is available to you.
- `flow`: app module structure, powered by
  [`{flow}`](https://github.com/moodymudskipper/flow).
- `reactlog`: app reactivity log explorator, powered by
  [`{reacltlog}`](https://rstudio.github.io/reactlog/).

## Installation

You can install the development version of shinyMons2 like so:

``` r
remotes::instal_github("RinteRface/posit-conf-2023-exercise")
```

### Package dependencies

Right after cloning the repository, don’t forget to restore the R
packages dependencies by doing:

``` r
renv::restore()
```

## Example

To run the app, source `app.R`.

## Code of Conduct

Please note that the shinyMons2 project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
