#' Unit Conversion
#'
#' @import dplyr
#' @importFrom tibble tibble tribble
#'
#' @param unit_actual actual unit
#' @param unit_target target unit
#'
#' @export
unit_conversion <- function(unit_actual, unit_target) {
  unit_actual <- match.arg(unit_actual,
                           choices = c("[kWh]", "[MWh]"),
                           several.ok = TRUE)
  unit_target <- match.arg(unit_target,
                           choices = c("[kWh]", "[MWh]"),
                           several.ok = TRUE)

  df_conv <- tribble(
    ~"unit_actual", ~"unit_target", ~"conv_factor",
    "[kWh]", "[kWh]", 1,
    "[kWh]", "[MWh]", 1E-3,
    "[MWh]", "[MWh]", 1,
    "[MWh]", "[kWh]", 1E3
  )

  tibble(unit_actual, unit_target) %>%
    left_join(df_conv, by = c("unit_actual", "unit_target")) %>%
    pull(conv_factor)
}
