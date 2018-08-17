module BotLang
  def help_msg 
    "Hello, currently i'm in development"
  end

  def add_msg(params)
    "Added #{params[0]} to blacklist"
  end

  def del_msg(params)
    "Removed #{params[0]} from blacklist"
  end
end