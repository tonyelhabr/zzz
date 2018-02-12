
# library(ProjectTemplate)
# create.project("letters")
# ?create.project
# ?load.project

e <- environment(load.project)

pt.contents <- ls(e)

for (item in pt.contents)
{
  cat(deparse(get(item, envir = e, inherits = FALSE)),
      file = file.path(project.name, paste(item, '.R', sep = '')))
}
