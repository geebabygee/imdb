require_relative 'scraper'
require 'yaml'
# IMDB Scrapper
# Write a program which scrapes the top 5 films on IMDB and dump this information into a movies.yml file:

# SCRAPER:
# 1) We need a function to scrape www.imdb.com/chart/top to get URLs
# 2) We need a function to scrape information for one specific movie
# 3) We need to put the movie information into a Hash.

# INTERFACE:
# 1) We fetch the urls
# 2) For each url, we call the scrape_movie method and store each hash in the movies array
# 3) We open a yml file, and write the movies to the yaml file
# - movies will be an array, we need to find what yaml method we can use to write it as a yaml.

puts "Fetching movies..."
movies = fetch_movie_urls.map do |url|
   scrape_movie(url)
end


puts "Saving in yaml file..."

File.open('data/movies.yml', 'wb') do |file|
  file.write(movies.to_yaml)
end

