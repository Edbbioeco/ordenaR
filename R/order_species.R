#' @title Ordening species by gradient and ranking them into a dataframe
#'
#' @description Based oh Hill (1973) reciprocal average, used to find best species ordenation to understand and visualize species abundace-composition under a gradient (see details). Can be used to direct gradient (numeric gradient, such as temperature, humidity, altitude, and other numeric variables) and indirect gradients (categorical gradientes, such as sample units, vegetation types, and other categorical variables).
#'
#' @details
#'
#' \href{https://www.jstor.org/stable/2258931}{Hill, M. O. (1973). Reciprocal averaging: an eigenvector method of ordination. Journal of Ecology, 61:237-249}.
#'
#' @param data Dataframe with gradient and species abundance columns.
#'
#' @param gradient Dataframe column with gradient data. May be column name as string ("gradient") or column dataframe id position number. If gradient is not NULL, direct argument is TRUE. only one gradient per time.
#'
#' @param species Dataframe columns with species abundace data. May be columns name as string (c("species_1", "species_2)) or columns dataframe id position number.
#'
#' @param direct If FALSE, function assumes gradient are an indirect gradient, with categorical data type. If direct = FALSE, do not needs to declare gradient argument. default is TRUE,

#' @examples
#'
#' # Load package
#'
#' library(ordenaR)
#'
#' library(purrr)
#'
#' # Importing data
#'
#' data("data_ordenar", package = "ordenaR")
#'
#' # Visualizing data
#'
#' data_ordenar
#'
#' # Calculing to a direct gradient
#'
#' ordenaR::order_species(data = data_ordenar,
#'                        gradient = "grandient_1",
#'                        species = 4:8)
#'
#' # Calculating to a indirect gradient
#'
#' ordenaR::order_species(data = data_ordenar,
#'                        species = 4:8,
#'                        direct = FALSE)
#'
#' # Loop for multiple gradients
#'
#' mult_gra <- function(gradient){
#'
#'   paste0("load to gradient: ", gradient) |>
#'     message()
#'
#'    grad <- ordenaR::order_species(data = data_ordenar,
#'                                   gradient = gradient,
#'                                   species = 4:8)
#'
#'    return(grad)
#'
#' }
#'
#' gradient <- paste0("gradient_", 1:2)
#'
#' purrr::map(gradient, mult_gra)
#'

#' @export

order_species <- function(data, gradient = NULL, species, direct = TRUE){

  if(!is.null(gradient) & direct == TRUE){

    ordem_especies <- data |>
      tidyr::pivot_longer(cols = species,
                          names_to = "specie",
                          values_to = "abundance") |>
      dplyr::summarise(`Reciprocal average` = sum(data[[gradient]] * abundance) / sum(abundance),
                       .by = specie) |>
      dplyr::arrange(`Reciprocal average` |> dplyr::desc()) |>
      dplyr::mutate(Rank = 1:length(species))

  } else if(is.null(gradient) & direct == FALSE){

    ordem_especies <- data |>
      dplyr::mutate(gradient = 1:nrow(data)) |>
      tidyr::pivot_longer(cols = species,
                          names_to = "specie",
                          values_to = "abundance") |>
      dplyr::summarise(`Reciprocal average` = sum(gradient * abundance) / sum(abundance),
                       .by = specie) |>
      dplyr::arrange(`Reciprocal average` |> dplyr::desc()) |>
      dplyr::mutate(Rank = 1:length(species))

  }

  return(ordem_especies)

}
