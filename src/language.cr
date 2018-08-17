module BotLang
  def help_msg 
    "Hello, currently i'm in development"
  end

  def debug_msg(message)
    "DEBUG\n#{Time.now}\n#{message.chat.id}"
  end

  def add_msg(params)
    "Added #{params[0]} to blacklist"
  end

  def add_error_msg(params)
    "Unable to add #{params[0]}"
  end

  def del_msg(params)
    "Removed #{params[0]} from blacklist"
  end

  def del_error_msg(params)
    "Unable to remove #{params[0]}"
  end

  def words_msg(q)
    "Current ban-words for this chat:\n#{q.to_pretty_json}"
  end
end