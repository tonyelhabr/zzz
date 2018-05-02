
rm(list = ls())

# Packages. ---
# library("dplyr")

# 
# solve:
# R = PD + R_other
# where
# n = # of g/tms played
# R_other = 
# [r_1    , (1 / n) * r_2   , (1 / n) * r_3 ... + (1 / n) * r_n
# [(1 / n) * r_1, r_2       , (1 / n) * r_3 ... + (1 / n) * r_n
#  ...]
# R = [r_1, r_2, ..., r_n]
# PD = [pd_1, pd_2, ..., pd_n]
# 
# i.e.
# r_1 = pd_1 + (1 / n) * (r_2 + r_3 + ... + r_n)
# r_2 = pd_2 + (1 / n) * (r_1 + r_3 + ... + r_n)

n <- 3
pd <- c(2, -8, 6)
wts1 <- matrix(rep(pd, n), byrow = TRUE, ncol = n)
diag(wts1) <- 0
dividend <- n - 1
wts2 <- wts1 / dividend
diag(wts2) <- pd
r <- rowSums(wts2)
r
wts1 <- matrix(rep(r, n), byrow = TRUE, ncol = n)


i <- 1
delta <- 1
dividend <- n - 1
while(delta > 0.1 & i < 10) {
  if(i == 1) {
    r_i <- pd
  }
  r_old <- r_i
  wts_i <- matrix(rep(r_i, n), byrow = TRUE, ncol = n)
  diag(wts_i) <- 0
  wts_out <- wts_i / dividend
  diag(wts_out) <- pd
  r_i <- rowSums(wts_out)
  i <- i + 1
  delta <- mean(abs(r_i - r_old))
  cat("iteration: ", i, "\n")
  cat("delta: ", round(delta, 2), "\n")
}

