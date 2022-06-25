library(rtweet, warn.conflicts = F, quietly = T)
library(jsonlite, warn.conflicts = F, quietly = T)
library(dplyr, warn.conflicts = F, quietly = T)
library(lubridate, warn.conflicts = F, quietly = T)

# Read Twitter API credentials- LOCAL MACHINE ONLY
# readRenviron(".env")


# Create a token for authenticating to Twitter
auth <- rtweet_bot(api_key = "IPvQg19aKRtTU884ccX1gHiyd",
                   api_secret = "rmLTm2tGUZwtQUWUR2F5mN7sCYiHUxtKjNVjVh6qmZhExy1ibR",
                   access_token = "1539944506551828482-wgdMFTNwsNsP4KA3j34vzir9vgZjVR",
                   access_secret = "JQXb0I6e99rnA9ePlnkEtILOhoj7KKgrlQacUyYYyrD1t"
                  )
auth_as(auth)

caption = readLines("caption.txt")
alt_text <- c(paste("A map of the United States showing",caption,"from the Census American Community Survey"))

post_tweet(status = caption, media = paste0(getwd(),"/",file.path("census.png")), media_alt_text = alt_text)
