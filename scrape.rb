require "nokogiri"
require "open-uri"
require_relative "lib/christmas_list"

search = input_for("What would you like to look for on ETSY?")
url = "https://www.etsy.com/search?q=#{search}"
html_string = open(url).read
doc = Nokogiri::HTML(html_string)
title_elements = doc.search(".v2-listing-card__info h3").first(5)

# Array of gift hashes
gift_ideas = title_elements.map do |title_element|
  { product: title_element.text.strip, bought: false }
end
display_list(gift_ideas)


# title_elements.each_with_index do |title_element, index|
#   puts "#{index + 1}. #{title_element.text.strip}"
# end
# index_to_be_added = input_for("What item would you like to add?").to_i - 1
# product = title_elements[index_to_be_added].text.strip
# new_gift_hash = {product: product, bought: false}
