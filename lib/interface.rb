require_relative 'christmas_list'
require "open-uri"
require "nokogiri"

GIFT_LIST = [
  { product: "necklace", bought: true },
  { product: "book", bought: false },
]

loop do
  puts "Which action [list|add|delete|mark|quit|idea]"
  user_input = gets.chomp.downcase
  case user_input
  when "list"
    display_list(GIFT_LIST)
  when "add"
    product = input_for("What item would you like to add?")
    gift_hash = { product: product, bought: false }
    GIFT_LIST << gift_hash
  when "delete"
    display_list(GIFT_LIST)
    item_index = input_for("What item would you like to delete").to_i - 1
    GIFT_LIST.delete_at(item_index)
  when "mark"
    display_list(GIFT_LIST)
    item_index = input_for("Which item do you want to mark/unmark?").to_i - 1
    gift_to_mark = GIFT_LIST[item_index]
    gift_to_mark[:bought] = !gift_to_mark[:bought]
  when "idea"
    user_query = input_for("What do you want to search for?")
    gift_ideas = scrape_gifts(user_query)
    display_list(gift_ideas)
    index_to_be_added = input_for("What item would you like to add?").to_i - 1
    GIFT_LIST << gift_ideas[index_to_be_added]
  when "quit"
    puts "Thank you for using this program"
    break
  end
end
