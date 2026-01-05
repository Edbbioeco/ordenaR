# Packages -----

library(devtools)

# Documentação ----

devtools::document()

# Checando o estado do pacote para encontrar conflitos ----

devtools::check(manual = TRUE, cran = TRUE)

# Finalizando checagens ----

devtools::release()

# Criando o pacote -----

devtools::build(path = getwd())
