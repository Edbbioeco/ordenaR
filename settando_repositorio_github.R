# Pacotes ----

library(usethis)

# Iniciando ----

usethis::use_git()

# Configurando o usuario e email ----

usethis::use_git_config(user.name = "Edbbioeco",
                        user.email = "edsonbbiologia@gmail.com")

# Projeto ----

usethis::proj_get()

# Settando o repositório ----

usethis::use_git_remote(name = "origin",
                        url = "https://github.com/Edbbioeco/ordenaR.git",
                        overwrite = TRUE)

# Criando o branch main ----

usethis::git_default_branch_configure()
