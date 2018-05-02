
library("dplyr")
library("ggplot2")

dir_trend <- "//ercot.com/sasshare/sasdata03/mav/"
dir_andres <- file.path(dir_trend, "users", "amaynez")
filenames_data <- c("Results2016", "Results2017")
ext <- "csv"
get_filepath <- function(dir, filename, ext, winslash = "/") {
  file.path(dir,  paste0(filename, ".", ext))
}
paths_data <-
  purrr::pmap_chr(list(dir = dir_andres, filename = filenames_data, ext = ext), get_filepath)
file.exists(paths_data)
import_data <- function(path, cols_idx = 1:8) {
  path %>%
    rio::import() %>%
    select(cols_idx) %>%
    tibble::as_tibble()
}
# data <-
#   purrr::map(paths_data, import_data) %>%
#   # purrr::flatten_dfr()
#   do.call("rbind", .)
data_raw <- paths_data[2] %>% import_data()
data_raw %>% summarize_all(funs(n_distinct))

clean_sas_date <- function(x) {
  lubridate::ymd_hms(strptime(tolower(z), "%d%b%y:%H:%M:%S"))
}


data <-
  data_raw %>%
  janitor::clean_names() %>%
  mutate_at(vars(interval, gmtintervalend), funs(clean_sas_date)) %>%
  mutate(
    year = lubridate::year(interval),
    month = lubridate::month(interval),
    day = lubridate::day(interval),
    wday = lubridate::wday(interval),
    hour = lubridate::hour(interval),
    minute = lubridate::minute(interval)
  ) %>%
  select(year, month, day, wday, hour, minute, everything())

data %>% group_by(stlmntlocname) %>% select(lmp, mlc, mcc, mec) %>% skimr::skim()

data_proc <-
  data %>%
  mutate(
    price_spread = mec - lmp,
    net_export = mcc - mlc
  )

viz_all <-
  data_proc %>%
  filter(stlmntlocname %in% "ERCOTE") %>%
  ggplot(aes(x = price_spread, y = net_export), color = ercotr::ercot_palette[1]) +
  geom_point(alpha = 0.1) +
  geom_smooth(method = "lm", se = FALSE) +
  coord_cartesian(xlim = c(-400, 600), ylim = c(-200, 300)) +
  teplot::theme_te()
viz_all
