module TBot
  module Helpers
    def is_admin?(msg)
      if msg.from
        admins_ids = get_chat_administrators(msg.chat.id).map {|admin| admin.user.id}
        admins_ids.includes?(msg.from.not_nil!.id)
      else
        false
      end
    end

    def by_msg_and_word(msg, params)
      Repo.all(Blacklist, Query.new.where(chat_id: msg.chat.id, word: params[0]))
    end

    def by_msg(msg)
      Repo.all(Blacklist, Query.new.where(chat_id: msg.chat.id))
    end


    def is_dangerous?(str, chat_id)
      if !str.nil?
        words = Repo.all(Blacklist, Query.new.where(chat_id: chat_id))
        words.each do |bl|
          return true if str.downcase.includes?(bl.word.not_nil!.downcase)
        end
      end
    end
    
    def reply_and_kick(msg)
      reply msg, kick_msg(msg)
      delete_message(msg.chat.id, msg.message_id)
      return if is_admin?(msg)
      kick_chat_member(msg.chat.id, msg.from.not_nil!.id)
      unban_chat_member(msg.chat.id, msg.from.not_nil!.id)
    end
  end
end