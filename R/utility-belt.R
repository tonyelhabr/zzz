
library("tidyverse")

# See https://rud.is/b/2018/04/08/dissecting-r-package-utility-belts/.
config <-
  list(
    path_data = file.path("data-raw", "utility-belt.rds")
  )

data <-
  config$path_data %>%
  readr::read_rds()
data
data %>%
  count(owner, sort = TRUE)
  # filter(str_detect(owner, "xi"))
data %>%
  filter(str_detect(pkg, "tidy")) %>%
  count(pkg, sort = TRUE)
