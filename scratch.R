elliott_count <- bike_data_monthly_loc %>% filter(loc == "Elliott") %>%
  ggplot(aes(y = monthly_total, x = Month))+
  geom_point()+
  geom_segment(aes(xend = Month, yend = 0, x = Month, y = monthly_total)) +
  scale_x_discrete(limits= c("January", " February", "March", "April ", "May", "June ", "Jul", "August", "September", "October", "November", "December"),
                   labels= c("January", " February", "March", "April ", "May", "June ", "Jul", "August", "September", "October", "November", "December"))+
  scale_y_continuous(labels = scales::comma)+
  labs(x = "Month", y = "Number of bikes", title = "Number of Bikes Counted at Elliott Bike station")+
  coord_flip()+
  theme_minimal()+
  theme( plot.title = element_text(hjust = 0.5, color = "#686868", size = 8,
                                   margin = margin(t = 10, r = 0, b = 15, l = 0)))
elliott_count




#sf dataframe ----
sf_places <-
  tribble(
    ~location,       ~lat,         ~long,
    "Elliott Bay Trail", 47.6162, -122.3539,
    "Burke Gilman Trail", 47.681610, -122.285061,
    "MTS Trail", 47.59047, -122.28651,
    "Chief Sealth Trail", 47.52826, -122.28105,
    "58th St", 47.67092, -122.38434,
    "Broadway (PBL)", 47.61341, -122.32070
  ) %>%
  st_as_sf(coords = c("long", "lat"), crs = 4326, agr = "constant")
# %>% st_transform(crs = "+proj=moll")




##ggplot option-----
ggplot(data = sf_places) +
  geom_sf(aes(geometry = geometry), color = "blue", size = 3) + # Plot the points
  geom_sf_label(aes(label = location), nudge_y = 0.01, check_overlap = TRUE, size = 3) + # Add labels
  labs(
    title = "Notable Locations in Seattle",
    subtitle = "A selection of trails and bike lanes.",
    caption = "Data: User-provided locations"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14),
    plot.subtitle = element_text(size = 10),
    plot.caption = element_text(size = 8),
    legend.position = "none"
  )








##another option----
tmap_mode("plot")

# Create the map with annotations
tm_map <- tm_shape(sf_places) +
  tm_basemap(server = "OpenStreetMap") + # Basemap
  tm_dots(size = 0.5, col = "red") +  # Plot points
  tm_text(text = "location", size = 0.6, col = "blue") + # Annotate each point with its location name
  tm_layout(title = "Points of Interest in Seattle")

# Print the map
print(tm_map)




#another tmap-----
tmap_mode("plot")

# Create the map
tm_map <- tm_shape(sf_places) +
  tm_basemap(server = "OpenStreetMap") + # Add OSM as basemap
  tm_dots(size = 0.3, col = "red") +  # Plot points, customize as needed
  tm_layout(title = "Points of Interest in Seattle")

# Print the map
print(tm_map)
