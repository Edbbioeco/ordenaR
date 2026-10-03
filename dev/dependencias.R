# Pacotes ----

library(tidyverse)

library(usethis)

# Pacotes ----

pacotes <- c("dplyr", "stringr", "readr", "ggplot2", "tibble", "forcats", "purrr")

pacotes

# Laço de repetição ----

pacotes_na_memoria <- function(pacotes){

  usethis::use_package(pacotes)

}

purrr::map(pacotes, pacotes_na_memoria)
