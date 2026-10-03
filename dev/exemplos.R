# Função order_species ----

order_species <- function(data, gradient, species, sample_unit = FALSE, rownames = FALSE){

  if(sample_unit == FALSE & roenames == FALSE){

    ordem_especies <- data |>
      tidyr::pivot_longer(cols = species,
                          names_to = "specie",
                          values_to = "abundance") |>
      dplyr::summarise(`Reciprocal mean` = sum(data_ordenar[[gradient]] * abundance) / sum(abundance),
                       .by = specie) |>
      dplyr::arrange(`Reciprocal mean` |> dplyr::desc()) |>
      dplyr::mutate(Rank = 1:length(species))

  }

  return(ordem_especies)

}
