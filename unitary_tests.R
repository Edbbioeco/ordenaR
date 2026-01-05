# Pacote ----

library(gert)

# Selecionando o arquivo ----

gert::git_add(list.files(pattern = "")) |> as.data.frame()

# Commitando ----

gert::git_commit("ordenaR package")

# Pushando ----

gert::git_push(remote = "origin", force = TRUE)

# Pullando ----

gert::git_pull()
