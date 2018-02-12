
time_now <- format(Sys.time(), "%Y%m%d-%H%M%S")
filepath_export <- paste0("O:/_other/projects/test_", time_now, ".txt")
# write.csv(time_now, filepath_export)
write(time_now, filepath_export)
