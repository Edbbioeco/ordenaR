# Pacote ----

library(gert)

# Selecionando o arquivo ----

gert::git_add(list.files(pattern = "comandos")) |> as.data.frame()

# Commitando ----

gert::git_commit("Script to git commands")

# Pushando ----

gert::git_push(remote = "origin", force = TRUE)

# Pullando ----

gert::git_pull()
