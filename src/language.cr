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
    "DEBUG\n#{Time.now}\n#{message.to_pretty_json}"
  end

  def add_msg(params)
    "Слово '#{params[0]}' добавлено в список."
  end

  def add_error_msg(params)
    "Невозможно добавить '#{params[0]}'."
  end

  def del_msg(params)
    "Cлово '#{params[0]}' удалено из списка."
  end

  def del_error_msg(params)
    "Невозможно удалить '#{params[0]}'"
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
end