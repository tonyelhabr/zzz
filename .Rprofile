
# options(rpubs.upload.method = "internal")
options(max.print = 50)
# options(scipen = 10)
# options(scipen = 1)
# options(digits = 2)
options(menu.graphics = FALSE)
options(prompt = "> ")
options(continue = "... ")
options(width = 80)

.First <- function() {
  options(
    # repos = c(CRAN = "https://cran.rstudio.com/"),
    browserNLdisabled = TRUE,
    deparse.max.lines = 2,
    
    pillar.bold = FALSE,
    pillar.sigfig = 4,
    # pillar.min_title_chars = Inf,
    pillar.min_title_chars = 20,
    pillar.subtle = TRUE,
    readr.num_columns = 0,
    
    # tibble.print_min = 20,
    tibble.print_min = 10,
    # tibble.print_max = 50,
    tibble.print_max = 20,

    # googlesheets.client_id = "905789985439-mu5o9ehkjrbk6niq0gj6aeib8fv49mup.apps.googleusercontent.com",
    # googlesheets.client_secret = "8HcnD5Nvf1WobEe-M6vUL38g",
    # googlesheets.httr_oauth_cache = FALSE,
    
    # devtools.desc.license = "MIT",
    devtools.name = "Tony",
    devtools.desc.author = "Tony ElHabr <anthonyelhabr@gmail.com> [aut, cre]"
    
  )

  if (interactive()) {
    # library(utils)

    # WARNING: Should only import these packages automatically during package development!
    library("devtools")
    # library("testthat")
    # library("sinew")
    # library("dplyr")

    print(devtools::session_info())
    utils::timestamp(prefix = paste("##-- [", getwd(), "] ", sep = ""))

  }
}

.Last <- function(){
  if(interactive()){
    hist_file <- Sys.getenv("R_HISTFILE")
    if(hist_file=="") hist_file <- "~/.RHistory"
    savehistory(hist_file)
  }
}
