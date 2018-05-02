
time_now <- format(Sys.time(), "%Y%m%d-%H%M%S")
path_export <- file.path(getwd(), paste0("test_", time_now, ".txt"))
write(time_now, path_export)
