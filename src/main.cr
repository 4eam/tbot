require "./language"
require "./repo/config"

class TBot < TelegramBot::Bot
  include TelegramBot::CmdHandler
  include BotLang

  def initialize(key)
    super("TBot", key)

    cmd "help" do |msg|
      reply msg, help_msg
    end

    cmd "add" do |msg, params|
      reply msg, add_msg(params)
    end

    cmd "del" do |msg, params|
      reply msg, del_msg(params)
    end
  end
end
