require "./tbot.cr"

puts "Initialize"
bot = TBot::Bot.new(TBot::Config::BOT_NAME, TBot::Config::BOT_KEY)
bot.polling