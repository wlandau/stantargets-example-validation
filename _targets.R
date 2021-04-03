library(targets)
library(tarchetypes)
library(stantargets)
source("R/functions.R")

# Uncomment below to use local multicore computing
# when running tar_make_clustermq().
options(clustermq.scheduler = "multicore")

# Uncomment below to deploy targets to parallel jobs
# on a Sun Grid Engine cluster when running tar_make_clustermq().
# options(clustermq.scheduler = "sge", clustermq.template = "sge.tmpl")

# These packages only get loaded if a target needs to run.
tar_option_set(packages = c("dplyr", "extraDistr", "rmarkdown"))

# future::plan(future::multisession)

list(
  tar_stan_mcmc_rep_summary(
    name = continuous,
    stan_files = "stan/model.stan",
    data = simulate_data_continuous(),
    chains = 4,
    iter_warmup = 100,
    iter_sampling = 100,
    batches = 2,
    reps = 2
  ),
  tar_stan_mcmc_rep_summary(
    name = discrete,
    stan_files = "stan/model.stan",
    data = simulate_data_discrete(),
    chains = 4,
    iter_warmup = 100,
    iter_sampling = 100,
    batches = 2,
    reps = 2,
  ),
  tar_target(cover_continuous, get_coverage(continuous)),
  tar_target(cover_discrete, get_coverage(discrete)),
  tar_render(report, "report.Rmd")
)
