
setwd("O:/_other/projects/misc/test_rmd_conditionals")
for (i in c(TRUE, FALSE)) {
  rmarkdown::render(
    "hw_rmd2r.R",
    params = list(soln = i),
    output_file = ifelse(i, "hw_solutions.docx", "hw_homework.docx")
  )
}

