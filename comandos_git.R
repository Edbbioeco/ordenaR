# Pacote ----

library(gert)

# Selecionando arquivos aptos ----

gert::git_status() |>
  as.data.frame()

# Adicionando arquivo ----

gert::git_add(list.files(pattern = "comandos_git.R")) |>
  as.data.frame()

# Commitando ----

gert::git_commit("Script to git Commands")

# Pushando ----

gert::git_push(remote = "origin", force = TRUE)

# Pullando ----

gert::git_pull(remote = "origin")

# resetando ----

gert::git_reset_mixed()

gert::git_reset_soft("HEAD~1")
