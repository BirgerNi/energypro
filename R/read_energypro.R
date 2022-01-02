#' Read Energypro
#'
#' Read energypro data from a csv file and return a tidy tibble
#'
#' @import assertthat
#' @importFrom purrr map_dfc
#' @importFrom readr read_csv
#' @importFrom stringr str_replace
#' @importFrom tidyr pivot_longer
#'
#' @param path path to csv file with energypro raw data
#'
#' @export
read_energypro <- function(path) {
  df_raw <- read_csv(path,
                     col_names = FALSE,
                     col_types = "c")

  assert_that(nrow(df_raw) == 7)
  assert_that(all(is.na(df_raw[3, ])))
  assert_that(df_raw[4, 1] == "Start")

  df_raw_filtered <- df_raw[4:7, 3:ncol(df_raw)]
  l <- list(name = 1, cat = 2, unit = 3, quantity = 4)

  map_dfc(l, function(x) as.character(df_raw_filtered[x, ])) %>%
    mutate(quantity = str_replace(quantity, ",", ".")) %>%
    mutate(quantity = as.numeric(quantity) * unit_conversion(unit, "[MWh]")) %>%
    mutate(ecu = parse_ecs(name),
           energy_in = parse_energy_in(name, cat),
           energy_out = parse_energy_out(name, cat)) %>%
    pivot_longer(cols = starts_with("energy"),
                 names_to = "direction", values_to = "energy_carrier") %>%
    filter(!is.na(energy_carrier)) %>%
    arrange(direction, energy_carrier, ecu) %>%
    group_by(direction, energy_carrier, ecu) %>%
    summarise(quantity = sum(quantity)) %>%
    ungroup()
}
