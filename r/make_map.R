# @knitr make_map

require(leaflet) 
require(dplyr) 
require(htmltools)
require(colorspace)
pacman::p_load(leaflet.extras)
custom_tile <- "http://b.sm.mapstack.stamen.com/((mapbox-water,$f2f7ff[hsl-color]),(positron,$f2f7ff[hsl-color]),(buildings,$f2f7ff[hsl-color]),(parks,$2c403b[hsl-color]))/{z}/{x}/{y}.png"

# pars
setview <- c(148.014016,-35.923479)
df <- data.frame(
  lon = c(144.950178, 151.209678),
  lat = c(-37.817694, -33.838149),
  label = c("Melbourne office", "Sydney office"),
  popup = c("717 Bourke St, Docklands", "1 Denison St, North Sydney"),
  colv = params$primary
)

ttl <- params$title
opac <- 0.7
zoom = 6


# pulse icons
marker_pulse <- makePulseIcon(
  color = params$primary,
  iconSize = 20,
  animate = T,
  heartbeat = 2
)

# iconset 
iconSet = pulseIconList(
  "melbourne" = makePulseIcon(color = params$primary),
  "sydney" = makePulseIcon(color = params$primary %>% lighten(0.5))
)


# easy buttons 
locate_me <- easyButton( # locate user
  icon="fa-crosshairs", title="Zoom to my position",
  onClick=JS("function(btn, map){ map.locate({setView: true}); }"));

reset_zoom <- easyButton( # reset zoom 
  icon="fa-globe", title="Reset zoom",
  onClick=JS("function(btn, map){ map.setZoom(5);}"));  

# text labels 
style <- list(
  "color" = params$primary,
  "font-weight" = "normal",
  "padding" = "8px"
)

# label options
marker_label_opt <- labelOptions(textsize = "20px", opacity = 0.5, offset = c(0, 0))
text_label_opt <- labelOptions(noHide = F, direction = "top", textsize = "15px",
                               textOnly = F, opacity = 0.7, offset = c(0,0),
                               style = style, permanent = T)
pulse_opt <- markerOptions(opacity = opac, riseOnHover = F, interactive = T)

# title 
map_title <- tags$style( 
  HTML(".leaflet-control.map-title { 
       transform: translate(-50%,20%);
       position: fixed !important;
       left: 50%;
       text-align: center;
       padding-left: 10px; 
       padding-right: 10px; 
       background: white; opacity: 0.5;
       font-size: 40px;
       }"
  ))

title <- tags$div(
  map_title, HTML(ttl)
)  




# map
map <- leaflet() %>%  # initiate the leaflet map object
  setView(setview[1], setview[2], zoom = zoom) %>%
  addTiles(custom_tile) %>%  # add map tiles to the leaflet object
  addPulseMarkers(df$lon, df$lat, 
                  icon = iconSet,  # marker_pulse, 
                  label=paste(df$label),
                  labelOptions = 
                    labelOptions(textsize = "20px",opacity = 0.5),
                  popup=paste0("<br>",df$popup,"<br>"),
                  popupOptions =
                    popupOptions(closeButton = T,autoPan = T),
                  group = "pulse1",
                  options = pulse_opt
  ) %>% 
  # addCircleMarkers(df$lon, df$lat,
  #                  radius = 10,
  #                  stroke = T,
  #                  weight = 3,
  #                  opacity = opac,
  #                  color = params$primary,
  #                  fillColor = params$primary,
  #                  popup=paste0("<br>",df$popup,"<br>"),
  #                  popupOptions =
  #                    popupOptions(closeButton = T,autoPan = T),
  #                  label=paste(df$label),
  #                  labelOptions =
  #                    labelOptions(textsize = "20px",opacity = 0.5)
  # ) %>%
  # addControl(title, position = "bottomleft", className = "map_title") %>% # add title
  addEasyButton(reset_zoom) %>% 
  addEasyButton(locate_me) 
map 
