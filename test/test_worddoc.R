

library("dplyr")
library("stringr")
dir_guide <- "//ercot.com/Departments/CRR/CRR Model Build/1 CRR Model Build Documents/"
filename_guide <- "crr_model_build_guide_v02.1.docx"
filepath_guide <-
  str_c(dir_guide, filename_guide)

rt_doc <- readtext::readtext(filepath_guide)
corpus_doc <- quanteda::corpus(rt_doc)
summary(corpus_doc)
str_length(corpus_doc$documents)
corpus_doc$documents$doc_id
