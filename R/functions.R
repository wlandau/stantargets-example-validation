#' @title Simulate data from the model.
#' @description Use a continuous covariate x.
#' @return A Stan data list with the following elements.
#'   * `y`: Simulated normal responses.
#'   * `x`: A simulated covariate of zeroes and ones.
#'   * `.join_data`: a named list of true parameters used to simulate
#'     the data. `stantargets` automatically includes `.join_data`
#'     in posterior summaries.
#' @param n Number of data points to simulate.
#' @examples
#' library(tidyverse)
#' simulate_data_continuous()
simulate_data_continuous <- function(n = 100) {
  alpha <- rnorm(1, 0, 1)
  beta <- rnorm(1, 0, 1)
  sigma <- rhcauchy(1, 1)
  x <- rnorm(n, 1, 1) # continuous covariate
  y <- rnorm(n, alpha + x * beta, sigma)
  list(
    n = n,
    x = x,
    y = y,
    .join_data = list(alpha = alpha, beta = beta, sigma = sigma)
  )
}

#' @title Simulate data from the model.
#' @description Use a discrete covariate x.
#' @return A Stan data list with the following elements.
#'   * `y`: Simulated normal responses.
#'   * `x`: A simulated covariate of zeroes and ones.
#'   * `.join_data`: a named list of true parameters used to simulate
#'     the data. `stantargets` automatically includes `.join_data`
#'     in posterior summaries.
#' @param n Number of data points to simulate.
#' @examples
#' library(tidyverse)
#' simulate_data_discrete()
simulate_data_discrete <- function(n = 100) {
  alpha <- rnorm(1, 0, 1)
  beta <- rnorm(1, 0, 1)
  sigma <- rhcauchy(1, 1)
  x <- rbinom(n, 1, 0.5) # discrete covariate
  y <- rnorm(n, alpha + x * beta, sigma)
  list(
    n = n,
    x = x,
    y = y,
    .join_data = list(alpha = alpha, beta = beta, sigma = sigma)
  )
}

#' @title Simulate data from the model.
#' @description Use a discrete covariate x.
#' @return A data frame with coverage rates of each model parameter
#'   in posterior intervals.
#' @param summaries A data frame returned by targets
#'   created by `stantargets::tar_stan_mcmc_rep_summary()`.
#' @examples
#' \donttest{
#' library(targets)
#' tar_make()
#' tar_load(continuous)
#' library(dplyr)
#' get_coverage(continuous)
#' }
get_coverage <- function(summaries) {
  summaries %>%
    filter(variable != "lp__") %>%
    group_by(variable) %>%
    summarize(
      coverage = round(mean(q5 < mean & mean < q95), 2),
      .groups = "drop"
    )
}
