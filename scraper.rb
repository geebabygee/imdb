require "open-uri"
require "nokogiri"
require "byebug"

def fetch_movie_urls
  url = "https://www.imdb.com/chart/top"
  html_file = open(url, "Accept-Language" => "en").read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search(".titleColumn a").first(5).map do |element|

    #need to build this  "http://www.imdb.com/title/tt0111161/",
    # puts element.attribute("href")
  "http://www.imdb.com#{element.attribute("href")}"
  end
end

def scrape_movie(url)
  # url = "http://www.imdb.com/title/tt0111161/"

  html_file = open(url, "Accept-Language" => "en").read
  html_doc = Nokogiri::HTML(html_file)
  h1 = html_doc.search("h1")
  p title = h1.text.strip[0..-8]
  year = h1.search("#titleYear a").text

  movie_hash = {}

  html_doc.search('.plot_summary').each do |element|
    director = element.search(".credit_summary_item a").first.text
    storyline = element.search(".summary_text").text.strip
    cast = element.search(".credit_summary_item").last.search('a').first(3).map do |sub_element|
      # cast = html_doc.search(".credit_summary_item:nth-child(4) a").first(3).map do |element|
       sub_element.text
    end
  movie_hash[:title] = title
  movie_hash[:director] = director
  movie_hash[:storyline] = storyline
  movie_hash[:cast] = cast
  movie_hash[:year] = year.to_i
  end
  movie_hash
end










