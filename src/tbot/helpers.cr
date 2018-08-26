module TBot
  module Helpers
    def check_admin(msg)
      return true if is_admin?(msg)
      reply msg, not_admin_msg(msg)
      false
    end

    def is_admin?(msg)
      msg.from.try do |user|
        admins_ids = get_chat_administrators(msg.chat.id).map {|admin| admin.user.id}
        return true if admins_ids.includes?(user.id)
      end
      false
    end

    def is_dangerous?(str, chat_id)
      str.try do |str|
        str = str.gsub(" ", "").downcase
        words = Repo.all(Blacklist, Query.new.where(chat_id: chat_id))
        words.each do |bl|
          return true if str.includes?(bl.word.not_nil!)
        end
      end
    end

    def user_exists?(user_id : Int32, chat_id : String) : Bool
      !Repo.get_by(User, user_id: user_id, chat_id: chat_id).nil?
    end

    def user_handler(msg)
      add_user(msg)
      left_user(msg)
      new_user_handler(msg)
    end
    
    def new_user_handler(msg) # Create user if by posted message
      msg.from.try do |user|
        user.username.try do |username|
          if !user_exists?(user.id, msg.chat.id.to_s) 
            User.create_from(user.id, msg.chat.id, username)
          end
        end
      end
    end

    def add_user(msg) # Create user if he just joined
      msg.new_chat_members.try do |users|
        users.each do |user|
          user.username.try do |username|
            if !user_exists?(user.id, msg.chat.id.to_s) 
              User.create_from(user.id, msg.chat.id, username)
            end
          end
        end
      end
    end

    def left_user(msg) # Delete user if he left
      msg.left_chat_member.try do |user|
        user.username.try do |username|
          User.delete_by(user.id, msg.chat.id, username)
        end
      end
    end
    
    
    def reply_and_kick(msg)
      reply msg, kick_msg(msg)
      delete_message(msg.chat.id, msg.message_id)
      return if is_admin?(msg)
      msg.from.try do |user|
        kick_chat_member(msg.chat.id, user.id)
        user.username.try do |username|
          User.delete_by(user.id, msg.chat.id, username)
        end
        unban_chat_member(msg.chat.id, user.id)
      end
    end
  end
end