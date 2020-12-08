library(curl)
library(leaflet)
library(dplyr)
library(htmlwidgets)

gh.sites.repo <- "https://raw.github.com/ercrema/Jomon_SPD_Comparison/"
gh.sites <- "master/data/sites.csv"
gh.data.sites <- read.csv(curl(paste0(gh.sites.repo, gh.sites)))
jomon.sites <- leaflet(gh.data.sites, height = "500px", width = "75%") %>%
  addTiles(group = "OSM") %>%
  addCircleMarkers(layerId = ~SiteName,
                   lng = ~Longitude, lat = ~Latitude,
                   popup = ~paste0(SiteId,".", SiteName, "<br><i>", Prefecture,"<\i>")
                   weight = 1,
                   radius = 3,
                   clusterOptions = markerClusterOptions(showCoverageOnHover = T,
                                                         zoomToBoundsOnClick = T))
saveWidget(jomon.sites, file = "lf_jomon_sites.html")
