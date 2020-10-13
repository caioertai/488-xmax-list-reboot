require "nokogiri"
require "open-uri"

def scrape_gifts(search)
  url = "https://www.etsy.com/search?q=#{search}"
  html_string = open(url).read
  doc = Nokogiri::HTML(html_string)
  title_elements = doc.search(".v2-listing-card__info h3").first(5)

  gift_ideas = title_elements.map do |title_element|
    { product: title_element.text.strip, bought: false }
  end

  return gift_ideas
end

def display_list(list)
  list.each_with_index do |gift, index|
    box = gift[:bought] ? "[X]" : "[ ]"
    puts "#{index + 1}. #{box} #{gift[:product]}"
  end
end

def input_for(label)
  puts label
  gets.chomp
end
