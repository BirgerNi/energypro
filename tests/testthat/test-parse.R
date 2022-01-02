test_that("parse energy conversion unit", {
  expect_equal(parse_ecs(name = "Kessel 1"), "Sonstige EUA")
  expect_equal(parse_ecs(name = "Biomethan-BHKW"), "BHKW")
  expect_equal(parse_ecs(name = c("Pelletkessel 1",
                                  "Pelletkessel 2",
                                  "BHKW 1")),
               c("Sonstige EUA", "Sonstige EUA", "BHKW"))
})


test_that("parse energy in", {
  expect_equal(parse_energy_in(name = "Pelletkessel 1",
                               cat = "Brennstoffbedarf"),
               "Holz")
  expect_equal(parse_energy_in(
    name = c("Erdgaskessel",
             "Erdgaskessel",
             "Exportiert Elektrizität",
             "Stromaufnahme Elektrizität"),
    cat = c("Brennstoffbedarf",
            "Wärmeerzeugung",
            "Spotmarkt",
            "Spotmarkt")),
    c("Erdgas", NA_character_, NA_character_, "Netzstrom"))
})


test_that("parse energy out", {
  expect_equal(parse_energy_out(name = "Pelletkessel 1",
                                cat = "Wärmeerzeugung"),
               "Wärme")
  expect_equal(parse_energy_out(
    name = c("Erdgaskessel",
             "Erdgaskessel",
             "Exportiert Elektrizität",
             "Stromaufnahme Elektrizität"),
    cat = c("Brennstoffbedarf",
            "Wärmeerzeugung",
            "Spotmarkt",
            "Spotmarkt")),
    c(NA_character_, "Wärme", "Strom aus PV oder Windkraft", NA_character_))
})
