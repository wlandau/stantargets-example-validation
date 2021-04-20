packages <- c(
  "dplyr",
  "extraDistr",
  "fs"
  "fst"
  "remotes",
  "rmarkdown",
  "targets",
  "tarchetypes"
)
install.packages(packages)
remotes::install_github("stan-dev/cmdstanr")
remotes::install_github("ropensci/stantargets")
cmdstanr::install_cmdstan()
