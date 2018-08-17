require "./config"
require "./repo/config"
require "./language"

module TBot
  class Bot < TelegramBot::Bot
    include TelegramBot::CmdHandler
    include BotLang
  
    def initialize(key)
      super("TBot", key)
  
      cmd "help" do |msg|
        reply msg, help_msg
      end

      cmd "debug" do |msg|
        reply msg, debug_msg(msg)
      end

      cmd "add" do |msg, params|
        bl = Blacklist.new
        bl.chat_id = msg.chat.id.to_s
        bl.word = params[0]
        chset = Repo.insert(bl)

        if chset.errors.any?
          reply msg, add_error_msg(params)
        else
          reply msg, add_msg(params)
        end
      end
  
      cmd "del" do |msg, params|
        q  = Query.new.where(chat_id: msg.chat.id, word: params[0])
        bl = Repo.all(Blacklist, q)
        if bl.any?
          Repo.delete(bl.first)
          reply msg, del_msg(params)
        else
          reply msg, del_error_msg(params)
        end 
      end

      cmd "words" do |msg|
        q     = Query.new.where(chat_id: msg.chat.id)
        words = Repo.all(Blacklist, q)

        reply msg, words_msg(words)
      end
    end
  end
end
