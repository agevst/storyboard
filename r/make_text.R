pacman::p_load(dplyr,readr)
here::here("text") %>% list.files("lorem", full.names = T) %>% read_lines
