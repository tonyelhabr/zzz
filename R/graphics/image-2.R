
library("magick")
library("ggplot2")

# path_viz <- file.path("figs", "test.png")
viz <-
  ggplot2::ggplot(mtcars, aes(x = mpg, y = factor(gear), color = factor(gear))) +
  ggplot2::geom_point() +
  ggplot2::ggtitle("Cars")
viz
# ggplot2::ggsave(filename = path_viz, plot = viz, width = 5, height = 4, dpi = 300)

get_img_dims <- function(img = NULL) {
  dims <- dim(img[1][[1]])
  dims[2:3]
}
get_img_height <- function(img = NULL) {
  get_img_dims(img)[2]
}

get_img_width <- function(img = NULL) {
  get_img_dims(img)[1]
}

add_logo <-
  function(x = NULL,
           ...,
           logo_height = 100,
           logo_width = 20,
           pad_v = 20,
           pad_h = 0,
           # pad_dim = c(pad_v, pad_h),
           pos_v = c("bottom", "top"),
           pos_h = c("right", "left"),
           # pos_dim = c(pos_v, pos_h),
           border = FALSE,
           border_w = 2,
           border_h = border_w,
           path = file.path("figs", "test.png"),
           path_logo = file.path("data", "logo.png")) {
    # x <- viz
    # path <- path_viz
    stopifnot(!is.null(x), ggplot2::is.ggplot(x))
    stopifnot(is.numeric(logo_height), length(logo_height) == 1)
    stopifnot(is.numeric(logo_width), length(logo_width) == 1)
    stopifnot(is.character(pos_v), is.character(pos_h))
    stopifnot(dir.exists(dirname(path)))
    stopifnot(file.exists(path_logo))

    pos_v <- match.arg(pos_v)
    pos_h <- match.arg(pos_h)
    ggplot2::ggsave(x, filename = path, ...)

    x <- magick::image_read(path)
    h_img_raw <- get_img_height(x)
    w_img_raw <- get_img_width(x)

    logo <-
      path_logo %>%
      magick::image_read() %>%
      magick::image_background(color = "white", flatten = TRUE)
    h_logo_raw <- get_img_height(logo)
    w_logo_raw <- get_img_width(logo)

    if(missing(logo_height)) {
      logo_height <- h_logo_raw
    }
    if(missing(logo_width)) {
      logo_width <- w_logo_raw
    }

    logo <-
      logo %>%
      magick::image_resize(stringr::str_glue("0x0+{logo_width}+{logo_height}"))
    h_diff <- h_img_raw - logo_height
    w_diff <- w_img_raw - logo_width

    ret <-
      x %>%
      magick::image_border("white", stringr::str_glue("{pad_h}x{pad_v}")) %>% # for padding
      magick::image_border("white", stringr::str_glue("0x{logo_height}")) # for the logo

    if(border) {
      stopifnot(is.numeric(border_w), length(border_w) == 1)
      ret <-
        ret %>%
        magick::image_border("black", "{border_w}x{border_h}") # around everything
    }

    if(pos_v == "top") {
      chop_v <- 2 * h_logo_raw + 2 * padding
      comp_v <- 0
    } else if(pos_v == "bottom") {
      chop_v <- 0
      comp_v <- h_img_raw
    }

    if(pos_h == "left") {
      comp_h <- 0
    } else if(pos_h == "right") {
      comp_h <- w_diff
    }

    ret <-
      ret %>%
      magick::image_chop(stringr::str_glue("0x{logo_height}+0+{chop_v}")) %>%
      magick::image_composite(logo, offset = stringr::str_glue("0x0+{comp_h}+{comp_v}"))

    magick::image_write(ret, path)
    ret
  }

viz_wlogo <-
  viz %>%
  add_logo(width = 5, height = 4, dpi = 300)
