# DB
require "sqlite3"
require "crecto"

# Requirements
require "telegram_bot"
require "totem"

# Internal
require "./src/main"

bot = TBot::Bot.new(TBot::Config::BOT_KEY)
bot.polling