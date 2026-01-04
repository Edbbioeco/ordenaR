data_ordenar <- data.frame(sample_unit = paste0("p-", 1:25),
                           gradient_1 = seq(0.78, 11.63, length.out = 25),
                           gradient_2 = c(seq(6.12, 7.89, length.out = 5),
                                          seq(0.27, 1.48, length.out = 5),
                                          seq(2.5, 3.17, length.out = 5),
                                          seq(3.13, 4.73, length.out = 5),
                                          seq(8.01, 9.89, length.out = 5)),
                           species_1 = c(rep(0, 20),
                                         4, 5, 6, 4, 3),
                           species_2 = c(rep(0, 15),
                                         1, 4, 7, 6, 2,
                                         rep(0, 5)),
                           species_3 = c(2, 3, 4, 3, 2,
                                         rep(0, 20)),
                           species_4 = c(rep(0, 5),
                                         4, 7, 9, 8, 8,
                                         rep(0, 15)),
                           species_5 = c(rep(0, 10),
                                         5, 7, 9, 10, 12,
                                         rep(0, 10)))

data_ordenar

usethis::use_data(data_ordenar, overwrite = TRUE)


