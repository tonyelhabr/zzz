
rm(list = ls())

# Packages. ---
library("dplyr")
library("tidyr")
# library("tibble")
library("lpSolve")

n <- 4
ls <- letters[1:n]
g <- expand.grid(bind_cols(x = ls, y = ls))
# g <- expand.grid(cbind(ls, ls))
g

set.seed(1)
g2 <- g %>% bind_cols(val = runif(nrow(g)))
g2 <- g %>% bind_cols(val = rnorm(nrow(g), 0, 1))
g2

# Be careful with rownames here...
m <- g2 %>%  spread(y, val) %>% select(-x) %>% setNames(NULL)
m

obj <- rep(1, ncol(m)) # c(1, 1, 1, 1)
cons <- as.matrix(m)
dirs <- rep("<=", nrow(m))
# rhs <- c(1:nrow(m))
rhs <- c(1, 4, 3, 2)
solution <- lp("max", obj, cons, dirs, rhs)
solution$solution
