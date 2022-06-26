library(tidycensus)
library(stringr)
library(ggplot2)
library(viridis)
library(tigris)

options(tigris_use_cache = TRUE)
options(scipen = 100)

survey = 'acs5/profile'
year = 2020

# Clean up from last run
if (file.exists("census.png")) {
  file.remove("census.png")
}

if (file.exists("caption.txt")) {
  file.remove("caption.txt")
}

create_random_visualization <- function(year,survey) {
  vars <- load_variables(year, survey, cache = TRUE)

  random_var <- vars[sample(1:nrow(vars),1),]
  
  random_color <- sample(LETTERS[1:7],1)

  census_data <- get_acs(geography = "state", variables = random_var$name, geometry = TRUE) %>%
    shift_geometry()
  
  clean_label <- str_split(random_var$label, "!!")[[1]]
  clean_label <- clean_label[!grepl("^[A-Z ]+$",clean_label)]
  clean_label <- str_to_sentence(paste(clean_label, collapse = " - "))
  
  clean_subtitle <- str_to_sentence(random_var$concept)
  clean_subtitle <- gsub("Acs","ACS",clean_subtitle)
  
  clean_subtitle <- paste("2016-2020",clean_subtitle,"-",random_var$name)
  
  message(paste("Now visualizing:", clean_label))
  
  visualization <- ggplot(census_data,aes(fill = estimate)) +
    geom_sf(color = NA) +
    scale_fill_viridis(option = random_color) +
    theme_minimal() + 
    labs(title = clean_label,
         subtitle = clean_subtitle,
         caption = "Random Census Visualizations | By Gavin Rozzi (@gavroz)")

  fileConn <- file("caption.txt")
  writeLines(clean_label, fileConn)
  close(fileConn)
  
  return(visualization)
}

create_random_visualization(year,survey)

ggsave("census.png",width = 14, height = 7)


