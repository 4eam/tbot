require "./config"
require "./repo/config"
require "./language"
require "./helpers"

module TBot
  class Bot < TelegramBot::Bot
    include TelegramBot::CmdHandler
    include TBot::Lang
    include TBot::Helpers
  
    def initialize(name, key)
      super(name, key)
  
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
        params.each do |word|
          if by_msg_and_word(msg, word).empty?
            bl = Blacklist.new
            bl.chat_id = msg.chat.id.to_s
            bl.word = word.downcase
            chset = Repo.insert(bl)
            if chset.errors.empty?
              reply msg, add_msg(word)
            else
              reply msg, add_error_msg(word)
            end
          else
            reply msg, add_error_msg(word)
          end
        end
      end
  
      cmd "del" do |msg, params|
        if !is_admin?(msg)
          reply msg, not_admin_msg(msg)
          next
        end
        params.each do |word|
          bl = by_msg_and_word(msg, word)
          if bl.any?
            Repo.delete(bl.first)
            reply msg, del_msg(word)
          else
            reply msg, del_error_msg(word)
          end 
        end
      end

      cmd "words" do |msg|
        words = by_msg(msg)
        reply msg, words_msg(words)
      end
    end

    def handle(msg : TelegramBot::Message)
      if text = msg.text || msg.caption
        if text[0] == '/'
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
