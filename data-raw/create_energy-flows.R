library(DiagrammeR)
library(DiagrammeRsvg)
library(magrittr)
library(rsvg)

grViz("
digraph input_ecu_output {
  rankdir = LR;
  # splines = ortho;

  node [shape = rectangle,
        fontname = Helvetica,
        fixedsize = true,
        width = 3]

  subgraph energy_in {
    ng [label = 'Erdgas']
    biogas [label = 'Biogas']
    biogas_local [label = 'Biogas, gebäudenah erzeugt']
    wood [label = 'Holz']
    el_grid [label = 'Netzstrom']
    el_re_in [label = 'Strom aus PV oder Windkraft']
    heat_re [label = 'Erdwärme, Geothermie,\nSolarthermie, Umgebungswärme']
    heat_process [label = 'Abwärme aus Prozessen']
    heat_waste [label = 'Wärme aus Verbrennung\nvon Siedlungsabfällen']
  }

  subgraph energy_conversion_units {
    ecu_chp [label = 'BHKW', height = 2]
    ecu_other [label = 'Sonstige EUA', height = 3]
  }

  subgraph energy_out {
    el_chp [label = 'Verdrängungsstrommix', height = 1.3]
    el_re_out [label = 'Strom aus\nPV oder Windkraft', height = 1.3]
    heat [label = 'Wärmeerzeugung', height = 1.3]
  }

  # relationships
  {ng, biogas, biogas_local} -> {ecu_chp, ecu_other}
  {wood, el_grid, el_re_in heat_re, heat_process, heat_waste} -> ecu_other

  ecu_chp -> {el_chp, heat}
  ecu_other -> {el_re_out, heat}

  # ng -> ecu_chp [style = invis]
  wood -> ecu_other [style = invis, weight = 100]
}
") %>%
  export_svg() %>%
  charToRaw() %>%
  rsvg_png("man/figures/energy-flows.png")
