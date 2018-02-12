


library("hexSticker")
library("ggplot2")

viz <-
  ggplot() +
  # geom_text(aes(x = 1, y = 1, label = "te"), size = 100) +
  theme_void()
# viz
? viridisLite::viridis
# te_pal <- viridisLite::viridis(n = 4, option = "viridis")
te_pal <- viridisLite::viridis(n = 4, option = "plasma")
# te_pal <- viridisLite::viridis(n = 4, option = "magma")
# te_pal <- viridisLite::viridis(n = 4, option = "inferno")
# scales::show_col(te_pal)

sticker(
  viz,
  package = "te",
  p_y = 1.0,
  p_color = "black",
  # p_family = "Arial",
  spotlight = TRUE,
  p_size = 80,
  h_size = 1.5,
  h_color = "black",
  h_fill = "yellow",
  filename = file.path(paste0("te.png"))
)

library(ggplot2)
library(magick)
library(here) # For making the script run without a wd
library(magrittr) # For piping the logo

# Make a simple plot and save it
ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point() +
  ggtitle("Cars") +
  ggsave(filename = paste0(here("/"), last_plot()$labels$title, ".png"),
         width = 5, height = 4, dpi = 300)

# Call back the plot
plot <- image_read(paste0(here("/"), "Cars.png"))
# And bring in a logo
# logo_raw <- image_read("http://hexb.in/hexagons/ggplot2.png")
logo_raw <- image_read(paste0(here("/"), "te.png"))
logo_raw
# image_scale(logo_raw, "120")

# Scale down the logo and give it a border and annotation
# This is the cool part because you can do a lot to the image/logo before adding it
logo <-
  logo_raw %>%
  image_scale(geometry = "100") %>%
  image_background(color = "white", flatten = TRUE) %>%
  image_border(color = "white", geometry = "100x19")
# image_append(image_scale(c(plot, logo), "500"), stack = TRUE)
# image_composite(plot, logo)
logo <-
  logo %>%
  image_annotate(text = "Tony ElHabr", color = "black", size = 30, location = "+50+50", gravity = "northeast")

logo <-
  image_annotate(NULL, text = "Tony", color = "black", size = 30, location = "+50+50", gravity = "northeast")
logo
# Stack them on top of each other
final_plot <- image_append(image_scale(c(plot, logo), "500"))
final_plot
# And overwrite the plot without a logo
image_write(final_plot, paste0(here("/"), last_plot()$labels$title, ".png"))
final_plot

image_graph(width = 800, height = 600, bg = "white", pointsize = 12,
            res = 72, clip = TRUE, antialias = TRUE)
ggplot()
dev.off()
g <- ggplot2::qplot(mpg, wt, data = mtcars, colour = cyl)
logo <- image_read("https://www.r-project.org/logo/Rlogo.png")
out <- image_composite(g, image_scale(logo, "x150"), offset = "+700+380")
out
