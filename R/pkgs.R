
pkgs <- installed.packages()

pkgs_save  <- as.vector(pkgs[is.na(pkgs[, "Priority"]), 1])
save(pkgs_save, file = "C:/Users/aelhabr/Desktop/installed_packages.rda")

load("C:/Users/aelhabr/Desktop/installed_packages.rda")
for (pkgs in 1:length(pkgs_save)) install.packages(pkgs_save[pkgs])
