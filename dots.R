

func_dots <- function(x = c(1:5, NA), dir = getwd(), ...) {
  dots_generic <- list(...)
  dots_advr <- eval(substitute(alist(...)))
  m <- mean(x, ...)
  filepaths <-
    list.files(path = dir, ...)
  list(dots_generic, dots_advr, m, filepaths)
}

func_dots(na.rm = TRUE)
func_dots(recursive = FALSE)
func_dots(na.rm = TRUE, recursive = FALSE)

#'
#'
#'
library("ggplot2")

viz <-
  ggplot(mtcars, aes(x = wt, y = mpg, color = factor(gear))) +
  geom_point(size = 2)
viz
gsave <- function(x = ggplot2::last_plot(), filepath = file.path(getwd(), "test.png"), ...) {
  # dots <- list(...)
  # cat(names(dots))
  # dots <- match.call()
  browser()
  dots <- list(...)
  ggplot2_params_explicit <- c("unit", "width", "height")
  params_diff_1 <- setdiff(names(dots), ggplot2_params_explicit)
  params_diff_2 <- setdiff(ggplot2_params_explicit, names(dots))
  if(length(params_diff_1) == 0) {
    message("all required matched")
  } else {
    message("something not matched")
  }
  params_diff <- setdiff(names(dots), ggplot2_params_explicit)
  message(params_diff)
  # dots_in <- ("in" %in% names(dots))
  # dots_w <- ("width" %in% names(dots))
  # dots_h <- ("height" %in% names(dots))
}

gsave(viz, unit = "in", width = "4", height = "4.5", dpi = 320)
gsave(viz, unit = "in", width = "4", dpi = 320)
gsave(viz, dpi = 320)
