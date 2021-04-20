packages <- c(
  "dplyr",
  "extraDistr",
  "fs",
  "fst",
  "remotes",
  "rmarkdown",
  "rprojroot",
  "rstudioapi",
  "targets",
  "tarchetypes"
)
install.packages(packages)
remotes::install_github("stan-dev/cmdstanr")
remotes::install_github("ropensci/stantargets")
root <- rprojroot::find_rstudio_root_file()
cmdstan <- file.path(root, "cmdstan")
fs::dir_create(cmdstan)
cmdstanr::install_cmdstan(cmdstan)
cmdstan <- max(list.files(cmdstan, full.names = TRUE))
writeLines(paste0("CMDSTAN=", cmdstan), file.path(root, ".Renviron"))
rstudioapi::restartSession()
