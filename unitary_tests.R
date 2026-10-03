# Packages -----

library(tidyverse)

library(usethis)

library(devtools)

# Fazer a ignoração dos arquivos no buide ----

purrr::map(
  list.files(pattern = ".Rmd$|.R$|^README|^cran-comments",
             full.names = TRUE),
  \(arquivo){

    usethis::use_build_ignore

    },
  .progress = TRUE)

# Documentação ----

devtools::document()

# Checando o estado do pacote para encontrar conflitos ----

devtools::check(manual = TRUE, cran = TRUE)

# Finalizando checagens ----

devtools::release()

# Criando o pacote -----

devtools::build(path = getwd())
