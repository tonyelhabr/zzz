
# See http://asbcllc.com/r_packages/realtR/2018/introduction/index.html

library("tidyverse")

locs <- "Round Rock, TX"
locations <-
  realtR::geocode(
    locations = locs,
    return_message = F
  )
locations %>%
  glimpse()

mrates <-
  realtR::mortgage_rates(return_wide = F)
mrates %>%
  glimpse()

trends <-
  realtR::trends(
    locations = locs,
    return_messages = F
  )
trends %>%
  glimpse()


trends_viz <-
  trends %>%
  mutate_at(vars(priceListingMedian), funs(. / 1e3)) %>%
  select(
    dateData,
    locationSearch,
    matches(
      "^price[Listing|Rent|PerSF]|^count[For|Rental|Sold]|^area|^pctRent"
    )
  ) %>%
  gather(metric, value, -c(dateData, locationSearch)) %>%
  mutate_if(is.numeric, funs(if_else(is.na(.), 0, .)))


library("teplot")
viz_trends <-
  trends_viz %>%
  ggplot(aes(x = dateData, y = value, color = locationSearch)) +
  geom_line(alpha = 0.8) +
  teplot::scale_color_set1() +
  scale_x_date(date_breaks = "12 months", date_labels = "%Y-%m") +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 3), trans = "log10") +
  facet_wrap( ~ metric, nrow = 3, scales = "free") +
  teplot::theme_te_facet()
viz_trends
