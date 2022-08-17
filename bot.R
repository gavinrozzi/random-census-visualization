library(rtweet, warn.conflicts = F, quietly = T)
library(dplyr, warn.conflicts = F, quietly = T)

# Read Twitter API credentials- LOCAL MACHINE ONLY
# readRenviron(".env")

source("random_census.R")

# Create a token for authenticating to Twitter
auth <- create_token(app = "randomcensus",
                   consumer_key = Sys.getenv("TWITTER_CONSUMER_API_KEY"),
                   consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
                   access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
                   access_secret = Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
                  )


caption = readLines("caption.txt")
alt_text <- c(paste("A map of the United States showing",caption,"from the Census American Community Survey"))

post_tweet(token = auth, status = caption, media = paste0(getwd(),"/",file.path("census.png")), media_alt_text = alt_text)
