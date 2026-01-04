# Pacotes ----

library(tidyverse)

library(magrittr)

library(hexSticker)

# Dados ----

## Criando ----

dados <- tibble::tibble(grad = seq(5.75, 0.5, length.out = 16),
                        `Species 1` = c(1, 4, 5, 3, rep(0, 12)),
                        `Species 2` = c(rep(0, 4),
                                6, 10, 9, 8,
                                rep(0, 8)),
                        `Species 3` = c(rep(0, 8),
                                5, 7, 8, 10,
                                rep(0, 4)),
                        `Species 4` = c(rep(0, 12),
                                        4, 5, 7, 6))

## Visualizando ----

dados

## Tratando ----

dados %<>%
  tidyr::pivot_longer(cols = dplyr::contains("Spe"),
                      names_to = "species",
                      values_to = "abundance")

dados

# Hexágono ----

## Gráfico ----

dados |>
  ggplot(aes(grad, abundance)) +
  geom_col(color = "darkgreen", fill = "darkgreen") +
  facet_grid(species~.) +
  geom_hline(yintercept = 0, color = "darkgreen", linewidth = 8) +
  scale_y_continuous(expand = FALSE,
                     limits = c(0, 11)) +
  labs(x = NULL,
       y = NULL) +
  theme_classic() +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.line.x = element_blank(),
        axis.line.y = element_line(color = "darkgreen", linewidth = 4),
        strip.background = element_blank(),
        strip.text.y.right = element_text(angle = 0,
                                          size = 125,
                                          color = "darkgreen",
                                          hjust = 0,
                                          face = "bold.italic"),
        panel.background = element_blank(),
        plot.background = element_blank()) +
  ggview::canvas(width = 10, height = 10)

ggsave(filename = "plot.png", height = 10, width = 10)
