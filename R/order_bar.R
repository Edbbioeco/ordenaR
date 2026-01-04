utils::globalVariables(c("abundance", "specie", "Reciprocal average", "gradientn"))

#' @title Build ordering plots by barplots
#'
#' @description Those plots are based oh Hill (1973) reciprocal average, used to find best species ordenation to understand and visualize species abundace-composition under a gradient. Can be used to direct gradient (numeric gradient, such as temperature, humidity, altitude, and other numeric variables) and indirect gradients (categorical gradientes, such as sample units, vegetation types, and other categorical variables).
#'
#' Those barplots are frequently used by ecological reseaches (Magnusson & Bacchario, 2021) to understand and visualize. Those barplots are mainly used to visualize:
#'
#' - How different species are ordened along a gradient;
#'
#' - How species abundance are ordered along a gradient.
#'
#' @param data Dataframe with gradient and species abundance columns.
#'
#' @param gradient Dataframe column with gradient data. May be column name as string ("gradient") or column dataframe id position number. only one gradient per time.
#'
#' @param species Dataframe columns with species abundance data. May be columns name as string (c("species_1", "species_2)) or columns dataframe id position number.
#'
#' @param direct If FALSE, function assumes gradient are an indirect gradient, with categorical data type. default is TRUE.
#'
#' @param width plot bar with, in numeric values. Default is NULL.
#'
#' @details
#'
#' Data input must to be a dataframe or tibble class object. Keep attention to secure data are not matrix or list class objects. Data input must contaign:
#'
#' - A column contain direct gradient (numeric values) or indirect gradient (categorical values). Pay attention whether your indirect gradient are contained on row names (i.e. sample units). If it is true, turn it into a columns, such using tibble::rownames_to_column() function, previously;
#'
#' - A set of Columns containing species abundance data. Pay attention such species abundance data are conttained by a single column.
#'
#' To Visualize data input structure, run ordenaR::data_ordenar.
#'
#' @references
#'
#' \href{https://www.jstor.org/stable/2258931}{Hill, M. O. (1973). Reciprocal averaging: an eigenvector method of ordination. Journal of Ecology, 61:237-249};
#'
#' \href{https://www.researchgate.net/publication/362367115_Exploring_patterns_in_ecological_data_with_multivariate_analyses}{Magnusson, W. E, Bacchario, F. B. (2021). Exploring patterns in ecological data with multivariate analyses. EDUA: Editora da Universidade Federal do Amazonas. Cap 2}.

#' @examples
#'
#' # Load packages
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
#' # Ploting to a direct gradient
#'
#' ordenaR::order_bar(data = data_ordenar,
#'                        gradient = "gradient_1",
#'                        species = 4:8)
#'
#' # Calculating to a indirect gradient
#'
#' ordenaR::order_bar(data = data_ordenar,
#'                        gradient = "sample_unit",
#'                        species = 4:8,
#'                        direct = FALSE)
#'
#' # Loop for multiple gradients
#'
#' mult_gra <- function(gradient){
#'
#'   paste0("Plot to gradient: ", gradient) |>
#'     message()
#'
#'    grad <- ordenaR::order_bar(data = data_ordenar,
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

order_bar <- function(data, gradient, species, direct = TRUE, width = NULL) {

  if(direct == TRUE){

    ordem_especies <- data |>
      tidyr::pivot_longer(cols = species,
                          names_to = "specie",
                          values_to = "abundance") |>
      dplyr::summarise(`Reciprocal average` = sum(data[[gradient]] * abundance) / sum(abundance),
                       .by = specie) |>
      dplyr::arrange(`Reciprocal average` |> dplyr::desc()) |>
      dplyr::pull(specie) |>
      unique()

    x_axis <- data[gradient] |> names()

    ggplt <- data |>
      dplyr::mutate(x_axis = data[[gradient]]) |>
      tidyr::pivot_longer(cols = species,
                          names_to = "specie",
                          values_to = "abundance") |>
      dplyr::mutate(specie = specie |>
                      forcats::fct_relevel(ordem_especies)) |>
      ggplot2::ggplot(ggplot2::aes(x_axis, abundance)) +
      ggplot2::geom_col(color = "black", fill = "black", width = width) +
      ggplot2::facet_grid(specie ~.) +
      ggplot2::labs(x = x_axis,
                    y = "Abundance") +
      ggplot2::geom_hline(yintercept = 0,
                          color = "black",
                          linewidth = 1) +
      ggplot2::theme_classic() +
      ggplot2::theme(axis.text.y = ggplot2::element_blank(),
                     axis.text.x = ggplot2::element_text(color = "black",
                                                         size = 15,
                                                         hjust = 0),
                     axis.title = ggplot2::element_text(color = "black",
                                                        size = 15),
                     panel.spacing = ggplot2::unit(0, "points"),
                     axis.ticks.y = ggplot2::element_blank(),
                     axis.line.x = ggplot2::element_blank(),
                     axis.line.y = ggplot2::element_line(color = "black",
                                                         linewidth = 1),
                     strip.background = ggplot2::element_blank(),
                     strip.text.y.right = ggplot2::element_text(angle = 0,
                                                                size = 12,
                                                                color = "black",
                                                                hjust = 0,
                                                                face = "bold.italic"),
                     legend.position = "bottom",
                     legend.text = ggplot2::element_text(color = "black",
                                                         size = 12),
                     legend.title = ggplot2::element_text(color = "black",
                                                          size = 15))

  } else if(direct == FALSE){

    ordem_especies <- data |>
      dplyr::mutate(gradientn = 1:nrow(data)) |>
      tidyr::pivot_longer(cols = species,
                          names_to = "specie",
                          values_to = "abundance") |>
      dplyr::summarise(`Reciprocal average` = sum(gradientn * abundance) / sum(abundance),
                       .by = specie) |>
      dplyr::arrange(`Reciprocal average` |> dplyr::desc()) |>
      dplyr::pull(specie) |>
      unique()

    species_order <- data |>
      dplyr::mutate(gradientn = 1:nrow(data)) |>
      tidyr::pivot_longer(cols = species,
                          names_to = "specie",
                          values_to = "abundance") |>
      dplyr::summarise(`Reciprocal average` = sum(gradientn * abundance) / sum(abundance),
                       .by = specie) |>
      dplyr::arrange(`Reciprocal average` |> dplyr::desc())

    ordem_amostras <- data |>
      tidyr::pivot_longer(cols = species,
                          names_to = "specie",
                          values_to = "abundance") |>
      dplyr::left_join(species_order,
                       by = "specie") |>
      dplyr::summarise(`Reciprocal average` = sum(`Reciprocal average` * abundance) / sum(abundance),
                       .by = data[gradient] |> names()) |>
      dplyr::arrange(`Reciprocal average`) |>
      dplyr::pull(data[gradient] |> names())

    x_axis <- data[gradient] |> names()

    ggplt <- data |>
      dplyr::mutate(x_axis = data[[gradient]]) |>
      tidyr::pivot_longer(cols = species,
                          names_to = "specie",
                          values_to = "abundance") |>
      dplyr::mutate(specie = specie |>
                      forcats::fct_relevel(ordem_especies),
                    x_axis = x_axis |>
                      forcats::fct_relevel(ordem_amostras)) |>
      ggplot2::ggplot(ggplot2::aes(x_axis, y = ifelse(abundance == 0,
                                                      NA,
                                                      abundance))) +
      ggplot2::geom_col(color = "black", fill = "black", width = width) +
      ggplot2::facet_grid(specie ~.) +
      ggplot2::labs(x = x_axis,
                    y = "Abundance") +
      ggplot2::geom_hline(yintercept = 0,
                          color = "black",
                          linewidth = 1) +
      ggplot2::theme_classic() +
      ggplot2::theme(axis.text.y = ggplot2::element_blank(),
                     axis.text.x = ggplot2::element_text(color = "black",
                                                         size = 15,
                                                         hjust = 1,
                                                         angle = 45),
                     axis.title = ggplot2::element_text(color = "black",
                                                        size = 15),
                     panel.spacing = ggplot2::unit(0, "points"),
                     axis.ticks.y = ggplot2::element_blank(),
                     axis.line.x = ggplot2::element_blank(),
                     axis.line.y = ggplot2::element_line(color = "black",
                                                         linewidth = 1),
                     strip.background = ggplot2::element_blank(),
                     strip.text.y.right = ggplot2::element_text(angle = 0,
                                                                size = 12,
                                                                color = "black",
                                                                hjust = 0,
                                                                face = "bold.italic"),
                     legend.position = "bottom",
                     legend.text = ggplot2::element_text(color = "black",
                                                         size = 12),
                     legend.title = ggplot2::element_text(color = "black",
                                                          size = 15))

    }

  return(ggplt)

}
