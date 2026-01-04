# Ordering species abundance by gradients by {[ordenaR](https://github.com/Edbbioeco/ordenaR)} <img src="ordenaR.png" width="250">

# Download and load package

``` r
library(remotes)

remotes::install_github("Edbbioeco/ordenaR")

library(ordenaR)
```

or simply:

``` r
install.packages("ordenaR")

library(ordenaR)
```

# Package funcionality

This package works to better understand species ordering by gradients,
and how gradients affect communities composition structure ([Hill,
1973](https://www.jstor.org/stable/2258931)). {ordenaR} package can
analyse species abundance under direct and indirect gradients
([Magnusson & Bacchario,
2021](https://www.researchgate.net/publication/362367115_Exploring_patterns_in_ecological_data_with_multivariate_analyses)):

- Direct gradients: numeric values gradients, such as temperature,
  humidity, altitude, and such else numeric variables;

- Indirect gradients, categorical values gradients, such as sample
  units, vegetation structure, location types, and such else categorical
  variables.

That package aload to use four functions:

- data_ordenar: input data for exemples;

- order_bar: ordering species by barplots

- order_circles: ordering species by circlesplots

- order_species: ordering species and ranking them into a dataframe.

# Input data

Toour exemples, we use ordenaR package data. First, lets load package
and next our data.

``` r
data("data_ordenar", package = "ordenaR")

data_ordenar
```

    ## # A tibble: 25 × 8
    ##    sample_unit gradient_1 gradient_2 species_1 species_2 species_3
    ##    <chr>            <dbl>      <dbl>     <dbl>     <dbl>     <dbl>
    ##  1 p-1               0.78      6.12          0         0         2
    ##  2 p-2               1.23      6.56          0         0         3
    ##  3 p-3               1.68      7.00          0         0         4
    ##  4 p-4               2.14      7.45          0         0         3
    ##  5 p-5               2.59      7.89          0         0         2
    ##  6 p-6               3.04      0.27          0         0         0
    ##  7 p-7               3.49      0.572         0         0         0
    ##  8 p-8               3.94      0.875         0         0         0
    ##  9 p-9               4.40      1.18          0         0         0
    ## 10 p-10              4.85      1.48          0         0         0
    ## # ℹ 15 more rows
    ## # ℹ 2 more variables: species_4 <dbl>, species_5 <dbl>

Next, lets get a summary about our data variables.

``` r
library(dplyr)

data_ordenar |> dplyr::glimpse()
```

    ## Rows: 25
    ## Columns: 8
    ## $ sample_unit <chr> "p-1", "p-2", "p-3", "p-4", "p-5", "p-6", "p-7", "p-8…
    ## $ gradient_1  <dbl> 0.780000, 1.232083, 1.684167, 2.136250, 2.588333, 3.0…
    ## $ gradient_2  <dbl> 6.1200, 6.5625, 7.0050, 7.4475, 7.8900, 0.2700, 0.572…
    ## $ species_1   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
    ## $ species_2   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 7,…
    ## $ species_3   <dbl> 2, 3, 4, 3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
    ## $ species_4   <dbl> 0, 0, 0, 0, 0, 4, 7, 9, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,…
    ## $ species_5   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 7, 9, 10, 12, 0, 0, …

To our analysis, we use dataframe/tibble class objetos, containg:

- A column contain direct gradient (numeric values) or indirect gradient
  (categorical values). Pay attention whether your indirect gradient are
  contained on row names (i.e. sample units). If it is true, turn it
  into a columns, such using tibble::rownames_to_column() function,
  previously;

- A set of Columns containing species abundance data. Pay attention such
  species abundance data are conttained by a single column.

# Get species rank

To best ordering species under a gradient, we relocate them in a plot,
to better understand how gradients affets species abundance. This is
based on Hill ([1973](https://www.jstor.org/stable/2258931)),
calculating reciprocal average, where every species get a rank, and we
relocate the species based on this rank. For indirect gradients, we
assumes a theorical gradient (i.e. 1, 2. 3, 4,…, n<sub>bservation</sub>)
and calcule them.

``` math

K_{PE} = \frac{\sum_{i = 1} \left(P_i * E_1 \right)}{\sum_{i = 1} P_i}
```

- $`P_i`$ = abundancie for species $`P`$ to row $`i`$;

- $`E_i`$ = value to gradient $`E`$ to row $`i`$.

Now, lets to analyse our data to a direct gradient.

``` r
ordenaR::order_species(data = data_ordenar,
                       gradient = "gradient_1",
                       species = 4:8)
```

    ## # A tibble: 5 × 3
    ##   specie    `Reciprocal average`  Rank
    ##   <chr>                    <dbl> <int>
    ## 1 species_1                10.7      1
    ## 2 species_2                 8.56     2
    ## 3 species_5                 6.38     3
    ## 4 species_4                 4.06     4
    ## 5 species_3                 1.68     5

``` r
ordenaR::order_species(data = data_ordenar,
                       gradient = "gradient_2",
                       species = 4:8)
```

    ## # A tibble: 5 × 3
    ##   specie    `Reciprocal average`  Rank
    ##   <chr>                    <dbl> <int>
    ## 1 species_1                8.89      1
    ## 2 species_3                7.00      2
    ## 3 species_2                4.01      3
    ## 4 species_5                2.90      4
    ## 5 species_4                0.951     5

And now to a indirect gradient.

``` r
ordenaR::order_species(data = data_ordenar,
                       gradient = "sample_unit",
                       species = 4:8,
                       direct = FALSE)
```

    ## # A tibble: 5 × 3
    ##   specie    `Reciprocal average`  Rank
    ##   <chr>                    <dbl> <int>
    ## 1 species_1                22.9      1
    ## 2 species_2                18.2      2
    ## 3 species_5                13.4      3
    ## 4 species_4                 8.25     4
    ## 5 species_3                 3        5

# References

- [Hill, M. O. (1973). Reciprocal averaging: an eigenvector method of
  ordination. Journal of Ecology,
  61:237-249](https://www.jstor.org/stable/2258931)}

- [Magnusson, W. E, Bacchario, F. B. (2021). Exploring patterns in
  ecological data with multivariate analyses. EDUA: Editora da
  Universidade Federal do Amazonas. Cap
  2](https://www.researchgate.net/publication/362367115_Exploring_patterns_in_ecological_data_with_multivariate_analyses)
