
library("magick")
library("ggplot2")

viz_void <- ggplot2::ggplot() + ggplot2::theme_void()
path_void <- file.path("figs", "void.png")
path_logo <- file.path("figs", paste0("logo.png"))
ggplot2::ggsave(path_void, plot = viz_void, units = "in", height = 1, width = 1, dpi = 100) # 100 x 100
img_void <- magick::image_read(path_void)
magick::image_write(magick::image_scale(img_void, "100"), path_void)
hexSticker::sticker(
  subplot = viz_void,
  package = "te",
  filename = path_logo,
  p_y = 1.0,
  p_color = "black",
  # p_family = "sans",
  p_size = 80,
  h_size = 1.5,
  h_color = "black",
  h_fill = "yellow"
)
logo <- magick::image_read(path_logo)
magick::image_write(magick::image_scale(logo, "120"), path = path_logo)
