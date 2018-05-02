

# Reference: https://xvrdm.github.io/ggplotext_meetup/#21

library("magick")
library("ggplot2")

add_logo <-
  function(x = NULL,
           title,
           path = file.path("figs", "test.png"),
           path_logo = file.path("data", "logo.png")) {
    x %>%
      ggsave(filename = path,
             width = 8,
             height = 3)
    if (missing(title)) {
      # title <- last_plot()$labels$title
      title <- ""
    }
    x <- image_read(path)
    height <-
      image_data(x) %>% attributes() %>% .$dim %>% .[[3]]
    ret <-
      x %>%
      image_border("white", "0x5") %>%
      image_border("red", "0x5") %>%
      image_border("white", "0x100") %>%
      image_chop(stringr::str_glue("0x{170}+0+{height+170+6*2+50*2}")) %>%
      # image_border("grey", "2x2") %>%
      image_background(color = "white", flatten = TRUE) %>%
      # image_composite(image_read(path_logo), offset = "+1870+30")
      image_composite(image_read(path_logo))
    image_write(ret, path)
    ret
  }

path_viz <- file.path("figs", "test.png")
viz <-
  ggplot2::ggplot(mtcars, aes(
    x = mpg,
    y = factor(gear),
    color = factor(gear)
  )) +
  ggplot2::geom_point() +
  ggplot2::ggtitle("Cars")
viz
# ggplot2::ggsave(filename = path_viz, plot = viz, units = "in", width = 4, height = 4)
#
# get_magick_image_dims <- function(img) {
#   dims <- dim(img[1][[1]])
#   dims[2:3]
# }

viz_wlogo <-
  viz %>%
  add_logo(path = path_viz)
viz_wlogo

