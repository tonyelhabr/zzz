

library("magick")
library("ggplot2")

path_viz <- file.path("figs", "test-custom.png")
viz <-
  ggplot2::ggplot(mtcars, aes(x = mpg, y = factor(gear), color = factor(gear))) +
  ggplot2::geom_point() +
  ggplot2::ggtitle("Cars")
viz
ggplot2::ggsave(filename = path_viz, plot = viz, width = 5, height = 4, dpi = 300)

get_magick_image_dims <- function(img) {
  dims <- dim(img[1][[1]])
  dims[2:3]
}

img_viz_raw <- magick::image_read(path_viz)
dims_viz_raw <- get_magick_image_dims(img_viz_raw)

viz_void <- ggplot2::ggplot() + ggplot2::theme_void()
path_void <- file.path("figs", "void.png")
ggplot2::ggsave(path_void, plot = viz_void, units = "in", height = 1, width = 1, dpi = 100)
img_void_raw <- magick::image_read(path_void)
dims_viz_void <- get_magick_image_dims(img_void_raw)

path_logo <- file.path("data", paste0("logo.png"))
img_logo_raw <- image_read(path_logo) %>% image_background(color = "white", flatten = TRUE)
dims_viz_logo <- get_magick_image_dims(img_logo_raw)
dim_h_footer <- 100
dim_h_footer_chr <- as.character(dim_h_footer)
dim_w_void_pad <- ceiling(dims_viz_raw[1] / 2)
dim_w_void_pad_chr <- as.character(dim_w_void_pad)
img_logo_pad <-
  image_append(
    c(
      image_border(image_scale(img_void_raw, dim_h_footer_chr), color = "white", geometry = dim_w_void_pad_chr),
      image_border(image_scale(img_logo_raw, dim_h_footer_chr), color = "white", geometry = "0x0")
    ),
    stack = FALSE)
img_logo_pad_ann <-
  img_logo_pad %>%
  image_annotate(text = "Tony", color = "black", size = dim_h_footer, location = "+0+0", gravity = "northwest")
dims_footer <- get_magick_image_dims(img_logo_pad_ann)
dims_viz_raw
dims_footer / dims_viz_raw
path_viz_new <- gsub("\\.png", "_new\\.png", path_viz)
image_write(image_append(c(img_viz_raw, image_scale(img_logo_pad, dims_viz_raw[1])), stack = TRUE), path = path_viz_new)

dim_h_footer <- 50
dim_h_footer_char <- as.character(dim_h_footer)
dim_w_logo <- 100
dim_w_logo_offset <- dims_viz_logo[2] - dim_w_logo
