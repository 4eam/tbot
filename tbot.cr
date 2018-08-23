# DB
require "sqlite3"
require "crecto"

# Requirements
require "telegram_bot"
require "totem"

# Internal
require "./src/main"

puts "Initialize"

include TBot::Helpers
chat_id = "-1001197398635"
json = JSON.parse(File.read("users.json")).as_h
json.each do |user_id, username|
  next if username == "None"
  if !user_exists?(user_id.to_i, chat_id) 
    User.create_from(user_id.to_i, chat_id, username.as_s)
  end
end



#bot = TBot::Bot.new(TBot::Config::BOT_NAME, TBot::Config::BOT_user_idEY)
#bot.polling