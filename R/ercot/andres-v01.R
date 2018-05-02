

library("dplyr")
library("readxl")
library("ggplot2")


filepath_data <- "ERCOT_CENACE(2016-2017).xlsx"
ws_name_1 <- "2016 Cenace"

# It's good practice to be explicit with package names.
readxl::excel_sheets(filepath_data)
# Or just do this if you've already loaded the library.
excel_sheets(filepath_data)

ws_names <- excel_sheets(filepath_data)
# Or... use the pipe to "chain"
ws_names <- filepath_data %>% excel_sheets()
ws_names

?readxl
?readxl::read_excel
data_raw <- filepath_data %>% read_excel(sheet = ws_names[2])
data_raw
# This is better (since the first row is not filled with headers).
data_raw <- filepath_data %>% read_excel(sheet = ws_names[2], skip = 1)
data_raw
# Now clean the names...
data_raw <- janitor::clean_names(data_raw)
data_raw

# Now, the same thing, all in one pipe.
data_raw <-
  filepath_data %>%
  read_excel(sheet = ws_names[2], skip = 1) %>%
  janitor::clean_names()

# Or, the same thing, without the pipe.
data_raw <- janitor::clean_names(read_excel(filepath_data, sheet = ws_names[2], skip = 1))
dplyr::summarize(dplyr::group_by(data_raw, year, month, day), r_price_delta = mean(r_price_delta))
data_raw_proc <- dplyr::mutate(data_raw, time = strftime(paste0(delivery_date, "-", sprintf("02f", delivery_hour)), "%Y-%m-%d-%H:00:00"))
dplyr::select(data_raw_proc, time)
ggplot2::ggplot2(data_raw, mappint = aes(x = delivery_hour, y = r_price_delta))
data_proc <-
  data_raw %>%
  mutate(time = delivery_date + lubridate::hours(delivery_hour)) %>%
  select(time, everything())

viz_all <-
  data_proc %>%
  ggplot(aes(x = time, y = r_price_delta)) +
  geom_line()
viz_all

viz_all_bymonth <-
  data_proc %>%
  ggplot(aes(x = delivery_hour, y = r_price_delta)) +
  geom_boxplot(aes(group = delivery_hour)) +
  facet_wrap(~month, scales = "free")
viz_all_bymonth

# names(data_raw)[grepl("net_exports_2", names(data_raw))]
# names(data_raw)[grepl("net_exports_2", names(data_raw))] <- c("net_exports_2a", "net_exports_2b")
#
# data_proc <-
#   data_raw %>%
#   mutate_at(vars(stl_point), funs(factor))

# ...

# # Another data set.
# exchange_rates <- janitor::clean_names(read_excel(filepath_data, sheet = ws_names[4]))
#
# exchange_rates
#
# # Getting advanced...
# exchange_rates <-
#   exchange_rates %>%
#   select_if(!stringr::str_detect(names(exchange_rates), "^x_"))
# exchange_rates

z <- 2
