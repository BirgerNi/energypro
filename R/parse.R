#' Parse Energy Conversion Unit
#'
#' Returns BHKW or Sonstige EUA
#'
#' @importFrom stringr str_detect
#'
#' @param name name from energypro
#'
#' @export
parse_ecs <- function(name) {
  name <- tolower(name)
  case_when(
    str_detect(name, "bhkw|chp") ~ "BHKW",
    TRUE ~ "Sonstige EUA"
  )
}


#' Parse Energy In
#'
#' @importFrom stringr str_detect
#'
#' @param name name from energypro
#' @param cat category from energypro
#'
#' @export
parse_energy_in <- function(name, cat) {
  name <- tolower(name)
  cat <- tolower(cat)

  case_when(
    is.na(name) ~ NA_character_,
    cat == "stromerzeugung" ~ NA_character_,
    cat == "w\u00E4rmeerzeugung" ~ NA_character_,
    str_detect(cat, "standort") ~ NA_character_,
    str_detect(name, "biomethan|bm|biogas") ~ "Biogas",
    str_detect(name, "pellet") ~ "Holz",
    str_detect(name, "erdgas|kessel") ~ "Erdgas",
    str_detect(name, "photovoltai|pv") ~ "Strom aus PV oder Windkraft",
    str_detect(name, "stromaufnahme") ~ "Netzstrom",
    TRUE ~ NA_character_
  )
}


#' Get Energy Out
#'
#' @importFrom stringr str_detect
#'
#' @param name name from energypro
#' @param cat category from energypro
#'
#' @export
parse_energy_out <- function(name, cat) {
  name <- tolower(name)
  cat <- tolower(cat)

  case_when(
    is.na(name) ~ NA_character_,
    cat == "brennstoffbedarf" ~ NA_character_,
    cat == "w\u00E4rmebedarf" ~ NA_character_,
    str_detect(name, "exportiert elektrizit") ~ "Strom aus PV oder Windkraft",
    cat == "w\u00E4rmeerzeugung" ~ "W\u00E4rme",
    TRUE ~ NA_character_
  )
}
