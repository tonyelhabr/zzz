

library("magick")
library("ggplot2")

viz_void <- ggplot2::ggplot() + ggplot2::theme_void()
filepath_void <- file.path(getwd(), "void.png")
filepath_logo <- file.path(getwd(), paste0("logo.png"))
ggplot2::ggsave(filepath_void, plot = viz_void, units = "in", height = 1, width = 1, dpi = 100) # 100 x 100
img_void <- magick::image_read(filepath_void)
magick::image_write(magick::image_scale(img_void, "100"), filepath_void)
hexSticker::sticker(
  subplot = viz_void,
  package = "te",
  filename = filepath_logo,
  p_y = 1.0,
  p_color = "black",
  # p_family = "sans",
  p_size = 40,
  h_size = 1.5,
  h_color = "black",
  h_fill = "yellow"
)
logo <- magick::image_read(filepath_logo)
magick::image_write(magick::image_scale(logo, "120"), path = filepath_logo)

filepath_viz <- file.path(getwd(), "test.png")
viz <-
  ggplot2::ggplot(mtcars, aes(x = mpg, y = factor(gear), color = factor(gear))) +
  ggplot2::geom_point() +
  ggplot2::ggtitle("Cars") +
  ggplot2::theme(legend.position = "none")
viz
ggplot2::ggsave(filename = filepath_test, plot = viz, units = "in", width = 4, height = 4)

get_magick_image_dims <- function(img) {
  dims <- dim(img[1][[1]])
  dims[2:3]
}

img_viz_raw <- magick::image_read(filepath_viz)
dims_viz_raw <- get_magick_image_dims(img_viz_raw)
img_void_raw <- magick::image_read(filepath_void)
dims_viz_void <- get_magick_image_dims(img_void_raw)
img_logo_raw <- magick::image_read(filepath_logo)
dims_viz_logo <- get_magick_image_dims(img_logo_raw)
dim_h_footer <- 100
dim_h_footer_char <- as.character(dim_h_footer)
dim_w_void_pad <- ceiling(dims_viz_raw[1] / 2)
dim_w_void_pad_char <- as.character(dim_w_void_pad)
img_logo_pad <-
  image_append(
    c(
      image_border(image_scale(img_void, dim_h_footer_char), color = "white", geometry = dim_w_void_pad_char),
      image_border(image_scale(img_logo, dim_h_footer_char), color = "white", geometry = "0x0")
    ),
    stack = FALSE)
img_logo_pad <-
  img_logo_pad %>%
  image_annotate(text = "Tony", color = "black", size = dim_h_footer, location = "+0+0", gravity = "northwest")
dims_footer <- get_magick_image_dims(img_logo_pad)
dims_viz_raw
dims_footer / dims_viz
filepath_viz_new <- gsub("\\.png", "_new\\.png", filepath_viz)
image_write(image_append(c(img_viz_raw, image_scale(img_logo_pad, dims_viz_raw[1])), stack = TRUE), path = filepath_viz_new)

dim_h_footer <- 50
dim_h_footer_char <- as.character(dim_h_footer)
dim_w_logo <- 100
dim_w_logo_offset <- dims_viz_logo[2] - dim_w_logo
