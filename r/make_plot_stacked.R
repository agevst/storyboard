

require(tidyr)
require(plotly)
require(colorspace)
require(patchwork)
remotes::install_github("allisonhorst/palmerpenguins") %>% suppressMessages()
require(palmerpenguins)
data(package = 'palmerpenguins') %>% suppressMessages()

my_theme <- theme(
  text = element_text(size = 7)
)

ttl1 <- "Palmer penguins"
subttl <- "Flipper length and body mass"
caption <- "Data: Palmer Station LTER"
xlab <- "Flipper length (mm)"  
ylab <- "Body mass (g)"
opac <- 0.7
colpal <- sequential_hcl(penguins$species %>% n_distinct, "Dark Mint")

p1 <- ggplot() +
  geom_point(data = penguins, aes(flipper_length_mm, body_mass_g, col = species, shape = species), size = 2, show.legend = F) +
  labs(title = ttl1, subtitle = subttl, caption = caption, x = xlab, y = ylab) +
  scale_colour_manual(values = colpal, aesthetics = "col", guide = "none") +
  theme_classic() +
  my_theme


ttl1 <- "Palmer penguins"
subttl <- "Flipper length"
caption <- "Data: Palmer Station LTER"
xlab <- "Flipper length (mm)"  
ylab <- "Frequency"
p2 <- ggplot() +
  geom_histogram(data = penguins, aes(flipper_length_mm, col = species, fill = species), col = NA) +
  labs(title = ttl1, subtitle = subttl, caption = caption, x = xlab, y = ylab) +
  scale_colour_manual(values = colpal %>% adjustcolor(opac), aesthetics = c("col","fill")) +
  theme_classic() +
  my_theme



