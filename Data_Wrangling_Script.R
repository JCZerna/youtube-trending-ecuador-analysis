#### --- Youtube videos trending in Ecuador: EDA Draft --- ####

# 1. Loading packages
# pacman is great because it installs missing packages automatically
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, reshape2, scales, lubridate, ggpubr, ggthemes, jsonlite)

# 2. Dataset reading 
# Since you are using an RProject, we use the filename directly
tYtvideos <- read.csv("trending_videos.csv")

# 3. Initial Review
glimpse(tYtvideos)
summary(tYtvideos)

# 4. Transforming Variables
# Using as_datetime to keep the hour/minutes data
tYtvideos <- tYtvideos %>% 
    mutate(published_at = as_datetime(published_at))

# Extract the hour for later analysis
tYtvideos <- tYtvideos %>% 
    mutate(publish_hour = hour(published_at))

# 5. Category Mapping
# This ensures your charts show "Music" instead of "10"
category_mapping <- c(
    "1" = "Film & Animation", "2" = "Autos & Vehicles", "10" = "Music",
    "15" = "Pets & Animals", "17" = "Sports", "18" = "Short Movies",
    "19" = "Travel & Events", "20" = "Gaming", "21" = "Videoblogging",
    "22" = "People & Blogs", "23" = "Comedy", "24" = "Entertainment",
    "25" = "News & Politics", "26" = "Howto & Style", "27" = "Education",
    "28" = "Science & Technology", "30" = "Movies", "31" = "Anime/Animation",
    "32" = "Action/Adventure", "33" = "Classics", "34" = "Comedy",
    "35" = "Documentary", "36" = "Drama", "37" = "Family", "38" = "Foreign",
    "39" = "Horror", "40" = "Sci-Fi/Fantasy", "41" = "Thriller",
    "42" = "Shorts", "43" = "Shows", "44" = "Trailers")

tYtvideos$category_name <- category_mapping[as.character(tYtvideos$category_id)]

# 6. Data Cleaning (Creating newdata1)
# Removing rows with 0 views/likes/comments and duration formatting
newdata1 <- tYtvideos %>%
    filter(view_count > 0, like_count > 0, 
           comment_count > 0) %>%
    mutate(
        duration_seconds = as.numeric(duration(duration)),
        duration_range = cut(duration_seconds, 
                             breaks = c(0, 300, 600, 1200, 3600, 
                                        7200, Inf),
                             labels = c("0-5 min", "5-10 min", 
                                        "10-20 min", 
                                        "20-60 min", "60-120 min", 
                                        "> 120 min")))

# 7. Correlation Analysis (Spearman)
# We select the columns for the heatmap
corrdata <- newdata1[,c("view_count", "like_count", 
                        "comment_count", 
                        "publish_hour", "duration_seconds")]
cormat <- round(cor(corrdata, method = "spearman"), 2)

# Melt for visualization
melted_cormat <- melt(cormat)

# Heatmap Plot
ggplot(data = melted_cormat, aes(x = Var1, y = Var2, fill = value)) + 
    geom_tile(color = "white") + 
    scale_fill_gradient2(low = "blue", high = "red", 
                         mid = "white", midpoint = 0) +
    geom_text(aes(label = value), color = "black", 
              fontface = "bold") +
    labs(title = "Spearman Correlation Heatmap", x = "", 
         y = "", fill = "Coeff") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                     hjust = 1))

# 8. Exporting for Power BI
write.csv(newdata1, "processed_youtube_ecuador.csv", 
          row.names = FALSE)
