packages <- c(
  "bs4Dash",
  "dplyr",
  "extraDistr",
  "fs",
  "fst",
  "gt",
  "markdown",
  "pingr",
  "remotes",
  "rmarkdown",
  "rprojroot",
  "rstudioapi",
  "shiny",
  "shinybusy",
  "shinycssloaders",
  "shinyWidgets",
  "targets",
  "tarchetypes",
  "tidyverse",
  "visNetwork"
)
install.packages(packages)
remotes::install_github("stan-dev/cmdstanr")
remotes::install_github("ropensci/stantargets")
cmdstanr::install_cmdstan()
