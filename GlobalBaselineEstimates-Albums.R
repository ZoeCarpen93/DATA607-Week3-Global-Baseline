View(ratings_df)

mu <- mean(ratings$Rating, na.rm = TRUE)

library(dplyr)

user_bias <- ratings_df %>%
  group_by(person) %>%
  summarise(user_avg = mean(rating, na.rm = TRUE)) %>%
  mutate(b_u = user_avg - mu)

item_bias <- ratings_df %>%
  group_by(album) %>%
  summarise(album_avg = mean(rating, na.rm = TRUE)) %>%
  mutate(b_i = album_avg - mu)

predictions <- expand.grid(
  person = unique(ratings_df$person),
  album  = unique(ratings_df$album)
) %>%
  left_join(user_bias, by = "person") %>%
  left_join(item_bias, by = "album") %>%
  mutate(pred_rating = mu + b_u + b_i)

recommendations <- ratings_df %>%
  left_join(predictions, by = c("person", "album")) %>%
  filter(is.na(rating)) %>%
  select(person, album, rating, pred_rating)


