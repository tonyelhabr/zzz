

library("dplyr")
# library("readxl")
library("ggplot2")

filepath_data <- "V:/edp/LMP_SL_2016.csv"

num_src <- 910
int_scaling_factor <- 12 * 24
num_int_1day <- num_src * int_scaling_factor

colnames <- c("INTERVAL", "GMTINTERVALEND", "STLMNTLOCNAME", "PNODENAME", "LMP", "MLC", "MCC", "MEC")
ymd_start <- as.Date("2016-01-01")
ymd_end <- as.Date("2016-12-31")
ymd_seq <- seq.Date(ymd_start, ymd_end, by = "day")
i <- 1
# while(i <= length(ymd_seq)) {
  ymd_i <- ymd_seq[i]

  data_raw_i <-
    filepath_data %>%
    readr::read_delim(
      delim = "|",
      col_names = colnames,
      skip = (1 + (i - 1) * num_int_1day),
      n_max = num_int_1day
    )

  ymd_hms_i <- data_raw_i %>% slice(1) %>% pull(INTERVAL)
  ymd_i <- format(ymd_hms_i, "%Y-%m-%d")
  filepath_out_i <-
    gsub("\\.csv", paste0("-", ymd_i, ".csv"), filepath_data)
  readr::write_csv(data_raw_i, filepath_out_i)
  message(sprintf("Done processing day %03.0f out of %.0f.", i, length(ymd_seq)))
  i <- i + 1
# }


data_raw <- data_raw_i %>% janitor::clean_names()
data_raw %>% summarize_all(funs(n_distinct))
data_raw %>% count(stlmntlocname, sort = TRUE)
data_raw %>%
  mutate(rn = row_number()) %>%
  filter(stringr::str_detect(stlmntlocname, "ERCOT"))

data_proc <-
  data_raw %>%
  # mutate(time = delivery_date + lubridate::hours(delivery_hour)) %>%
  mutate(time = interval) %>%
  rename(src = stlmntlocname, snk = pnodename) %>%
  select(time, src, snk, everything())

data_summ_bytime <-
  data_proc %>%
  group_by(time) %>%
  summarize_at(vars(lmp), funs(mean)) %>%
  ungroup() %>%
  arrange(desc(lmp))
data_summ_bytime

viz_all <-
  data_summ_bytime %>%
  ggplot(aes(x = time, y = lmp)) +
  geom_point() +
  geom_smooth()
viz_all

data_summ_bypnt <-
  data_proc %>%
  group_by(src) %>%
  summarize_at(vars(lmp), funs(mean)) %>%
  ungroup() %>%
  arrange(desc(lmp))

data_summ_bypnt %>%
  ggplot(aes(x = lmp)) +
  geom_histogram()


readr::write_csv(data_raw, path = file.path(
