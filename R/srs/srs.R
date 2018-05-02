
rm(list = ls())

# Packages. ---
# library("dplyr")

# 
# solve:
# X * R = PD
# where
# X = 
# [-1    , (1/16)   , (1/16) ...
# [(1/16), -1       , (1/16) ...
#  ...]
# R = [r_tm1, r_tm2, ..., r_tm3]
# PD = [pd_tm1, pd_tm2, ..., pd_tm3]
# 
# i.e.
# r_tm1 = pd_tm1 + (1 / sum(tms_played)) * (r_tm2 + r_tm3 + ...)
# r_tm2 = pd_tm2 + (1 / sum(tms_played)) * (r_tm1 + r_tm3 + ...)

n <- 3
set.seed(1)
m1 <- matrix(nrow = n, ncol = n)
# vals <- seq(from = 1, to = n*(n + 1) / 2)
val_max <- 20
vals <- round(runif(n*(n + 1) / 2, min = -val_max, max = val_max), 0)
m1[lower.tri(m1, diag = TRUE)] <- vals
m1
m2 <- t(m1)
m2[lower.tri(m2, diag = TRUE)] <- -vals
# m <- pmax(m1, t(-m1), na.rm = TRUE)
m2

wts1 <- m2
diag(wts1) <- 0
wts1
pds <- rowSums(wts1)
pds

i <- 1
delta <- 1
while(delta > 0.1 & i < 100) {

  wts2 <- (1/ (n - 1)) * wts1
  wts2
  diag(wts2) <- pds

  r <- round(solve(wts, pds), 2)
  r
  i <- i + 1
  delta <- 0.1
}
rowSums(wts1)
rowSums(wts2)



a <- matrix(
  c(1 / 1, -8 / 2, 6 / 2,
    2 / 2, 1 / 1, 6 / 2,
    2 / 2, -8 / 2, 1 / 1),
  ncol = 3)
b <- c(2, -8, 6)
a %*% b
solve(a)
solve(a, b)

library("lpSolve")

constr <- a

