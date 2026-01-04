# Pacote ----

library(gert)

# Selecionando o arquivo ----

gert::git_add(list.files(pattern = "settando")) |> as.data.frame()

# Commitando ----

gert::git_commit("Script o set github repository")

# Pushando ----

gert::git_push(remote = "origin", force = TRUE)

# Pullando ----

gert::git_pull()
