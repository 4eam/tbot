module TBot::Lang
  def help_msg
    ["Я создан для бана.",
    " /words - увидеть список запр. слов",
    "Админ. функции:",
    " /users - вывести количество пользователей",
    " /add {word} - добавить слово в блэклист",
    " /del {word} - удалить слово из блэклиста",
    " /bugreport {text} - сообщить разработчикам об ошибке"].join("\n")
  end

  def debug_msg(message)
    message.to_pretty_json
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
    "Функция недоступна, потому что вы не админ"
  end

  def kick_msg(msg)
    from = msg.from.not_nil!
    "Пользователь '#{from.first_name} #{from.last_name}' нарушил правила чата"
  end

  def users_msg(count)
    "Количество пользователей в чате: #{count}"
  end

  def report_msg(msg)
    text = msg.text.not_nil!
    chat = msg.chat.not_nil!
    from = msg.from.not_nil!
    ["Сообщение об ошибке от пользователя: \"#{from.first_name} #{from.last_name}\" @#{from.username}",
      "(Из чата \"#{chat.title}\" @#{chat.username})",
      "",
      "#{text[10..-1]}"].join("\n")
  end

  def report_have_sent
      "Сообщение отправлено разработчикам."
  end
end
