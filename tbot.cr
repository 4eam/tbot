require "sqlite3"
require "crecto"
require "telegram_bot"
require "totem"
require "./src/main"

totem = Totem.from_file("./config.yaml")
bot_key = totem.get("bot_api_key").as_s

puts "Hello world!"
bot = TBot.new(bot_key)
bot.polling