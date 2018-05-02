
# Reference: https://www.danielphadley.com/ggplot-logo/

library(ggplot2)
library(magick)
library(here) # For making the script run without a wd
library(magrittr) # For piping the logo

# Make a simple plot and save it
path_viz <- file.path("figs", "Cars.png")
viz <-
  ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point() +
  ggtitle("Cars")
viz
ggsave(viz, filename = path_viz, width = 5, height = 4, dpi = 300)

# Call back the plot
plot <- image_read(path_viz)
# And bring in a logo
# logo_raw <- image_read("http://hexb.in/hexagons/ggplot2.png")
path_logo <- file.path("data", "logo.png")
logo_raw <- image_read(path_logo)
logo_raw
# image_scale(logo_raw, "120")

# Scale down the logo and give it a border and annotation
# This is the cool part because you can do a lot to the image/logo before adding it
logo <-
  logo_raw %>%
  # image_scale(geometry = "100") %>%
  image_background(color = "white", flatten = TRUE) %>%
  image_border(color = "white", geometry = "100x19")
# image_append(image_scale(c(plot, logo), "500"), stack = TRUE)
# image_composite(plot, logo)
# logo <-
#   logo %>%
#   image_annotate(
#     text = "Tony ElHabr",
#     color = "black",
#     size = 10,
#     location = "+50+50",
#     gravity = "northeast"
#   )
logo
# Stack them on top of each other
final_plot <- image_append(image_scale(c(plot, logo), "500"), stack = TRUE)
final_plot
# And overwrite the plot without a logo
image_write(final_plot, path_viz)
final_plot
