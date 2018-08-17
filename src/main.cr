require "./config"
require "./repo/config"
require "./language"
require "./helpers"

module TBot
  class Bot < TelegramBot::Bot
    include TelegramBot::CmdHandler
    include TBot::Lang
    include TBot::Helpers
  
    def initialize(key)
      super("TBot", key)
  
      cmd "help" do |msg|
        reply msg, help_msg
      end

      cmd "debug" do |msg|
        reply msg, debug_msg(msg)
      end

      cmd "add" do |msg, params|
        if !is_admin?(msg)
          reply msg, not_admin_msg(msg)
          next
        end
        if by_msg_and_word(msg, params).empty?
          bl = Blacklist.new
          bl.chat_id = msg.chat.id.to_s
          bl.word = params[0]
          chset = Repo.insert(bl)
  
          if chset.errors.empty?
            reply msg, add_msg(params)
            next
          end
        end
        reply msg, add_error_msg(params)
      end
  
      cmd "del" do |msg, params|
        if !is_admin?(msg)
          reply msg, not_admin_msg(msg)
          next
        end
        bl = by_msg_and_word(msg, params)
        if bl.any?
          Repo.delete(bl.first)
          reply msg, del_msg(params)
        else
          reply msg, del_error_msg(params)
        end 
      end

      cmd "words" do |msg|
        words = by_msg(msg)
        reply msg, words_msg(words)
      end
    end

    def handle(msg : TelegramBot::Message)
      if text = msg.text || msg.caption
        if text.includes?("/")
          super
        elsif is_dangerous?(text, msg.chat.id)
          reply_and_kick(msg)
        elsif msg.entities
          msg.entities.not_nil!.each do |entity|
            if is_dangerous?(entity.url, msg.chat.id)
              reply_and_kick(msg)
              break
            end
          end
        end
      end
    end
  end
end
