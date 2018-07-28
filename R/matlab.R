
library("tidyverse")

# 1. ----
b <-
  matrix(
    data = c(
    seq(1L, 7L, 1L),
    seq(9L, -3L, -2L),
    2L ^ seq(2L, 8L, 1L)
    ),
    nrow = 3, ncol = 7, byrow = TRUE
  )
b

# 2. ----
a <- "Need-to-break-this-string"
a %>% str_split_fixed("-", n = 5)

# 3. ----
# readr::read_csv(path)

# 4. ----
a <- t(c(1, 2, 3))
b <- t(c(2, 4, 7))
a / b
b / a

# 5. ----

# 6. ----
# 7. ----
a <- matrix(
  data =
    c(
      c(1, 4, 3, 2),
      c(-3, 4, -5, 1),
      c(5, 6, 1, 2),
      c(-2, -3, 5, 6)
    ),
  nrow = 4, ncol = 4, byrow = TRUE
)
c <- a[c(1:3), c(2:3)]
c
s <- sum(a)
s
d <- a * (a * diag(a))
d
e <- a[c(3:4), c(3:4)] * t(a[c(3:4), c(3:4)])
e

# 8. ----
# FALSE

# 8. ----

v <- seq(2, 2 * 30, by = 2)
v %*% v
purrr::map_dbl(v, `*`)
(2 ^ 30) * factorial(30)
?factorial
