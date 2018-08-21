module TBot::Lang
  def help_msg 
    "Я создан для бана. 
 /help - помощь
 /words - увидеть список запр. слов
 Админ. функции:
 /add {word} - добавить слово в блэклист
 /del {word} - удалить слово из блэклиста"
  end

  def debug_msg(message)
    "DEBUG
#{Time.now}
ADMINS:
#{get_chat_administrators(message.chat.id).to_pretty_json}
USERS (DB):
#{Repo.all(User, Query.where(chat_id: message.chat.id))}"
  end

  def add_msg(word)
    "Слово '#{word}' добавлено в список."
  end

  def add_error_msg(word)
    "Невозможно добавить '#{word}'."
  end

  def del_msg(word)
    "Cлово '#{word}' удалено из списка."
  end

  def del_error_msg(word)
    "Невозможно удалить '#{word}'"
  end

  def words_msg(q)
    m = q.map {|bl| bl.word}
    "Текущий список запр. слов для чата:\n#{m.join(",\n")}"
  end

  def not_admin_msg(msg)
    "Функция недоступна, потому-что вы не админ"
  end

  def kick_msg(msg)
    from = msg.from.not_nil!
    "Пользователь '#{from.first_name} #{from.last_name}' @#{from.username} нарушил правила чата"
  end

  def users_msg(users)
    users.map {|user| "#{user.username}: #{users.user_id}"}.join("\n")
  end
end