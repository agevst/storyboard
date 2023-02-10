
x <- paste(
  ".Rhistory",
  ".Rproj.user",
  ".Rdata",
  ".Ruserdata",
  "*.mp4",
  "*.pptx",
  sep = "\n"
)
x %>% readr::write_lines(
  ".gitignore"
)