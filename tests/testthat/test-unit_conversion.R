test_that("parse unit conversion", {
  expect_equal(unit_conversion(unit_actual = "[kWh]",
                               unit_target = "[MWh]"),
               1E-3)

  expect_equal(
    unit_conversion(unit_actual = c("[kWh]", "[kWh]", "[MWh]", "[MWh]"),
                    unit_target = c("[kWh]", "[MWh]", "[MWh]", "[kWh]")),
    c(1, 1E-3, 1, 1E3))
})
