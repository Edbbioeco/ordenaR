# Packages -----

library(tidyverse)

library(usethis)

library(devtools)

# Fazer a ignoração dos arquivos no buide ----

purrr::walk(
  list.files(path = "./dev",
             full.names = TRUE),
  \(arquivo){

    usethis::use_build_ignore(arquivo)

    },
  .progress = TRUE)

# Mover a logo para o local correto ----

usethis::use_logo("ordenaR.png")

file.remove("ordenaR.png")

# Declarar rlang como dependência ----

usethis::use_package("rlang")

# Documentação ----

devtools::document()

# Checando o estado do pacote para encontrar conflitos ----

devtools::check(manual = TRUE, cran = TRUE)

# Finalizando checagens ----

devtools::release()

# Criando o pacote -----

devtools::build(path = getwd())
