
library("EIAdata")
key <- "5b8ab39da690a6a7425d71ee4ed31913"

?getEIA
?getCatEIA

cat_elect <-
  getCatEIA(cat = "Electricity", key = key)
cat_elect
cat <-
  getCatEIA(cat = 1, key = key)
cat
# id = ELEC.GEN.[type]-[state]-[cat_id].[frequency]
wind <-
  getEIA("ELEC.GEN.WND-TX-99.A", key = key)
solar_rooftop <-
  getEIA("ELEC.GEN.DPV-TX-99.A", key = key)
