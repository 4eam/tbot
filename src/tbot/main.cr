require "./config"
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
        next unless check_admin(msg)
        reply msg, debug_msg(msg)
      end

      cmd "users" do |msg|
        next unless check_admin(msg)
        count = User.count(chat_id: msg.chat.id)
        reply msg, users_msg(count)
      end

      cmd "add" do |msg, params|
        next unless check_admin(msg)

        params.each do |word|
          list = Blacklist.by(
            chat_id: msg.chat.id.to_s.downcase,
            word: word
          )
          if list.empty?
            chset = Blacklist.create_by(msg.chat.id, word)
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
        next unless check_admin(msg)

        params.each do |word|
          bl = Blacklist.by(chat_id: msg.chat.id, word: word.downcase)
          if bl.any?
            Blacklist.delete(bl.first)
            reply msg, del_msg(word)
          else
            reply msg, del_error_msg(word)
          end
        end
      end

      cmd "words" do |msg|
        words = Blacklist.by(chat_id: msg.chat.id)
        reply msg, words_msg(words)
      end

      cmd "bugreport" do |msg|
        next unless check_admin(msg)
        send_message(TBot::Config::REPORT_CHAT, report_msg(msg))
        reply msg, report_have_sent
      end
    end

    def handle(msg : TelegramBot::Message) # Main handler for messages
      # Create user by message if not exists
      # Create if just joined
      # Delete if left from chat
      user_handler(msg)

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
