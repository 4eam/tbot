class TBot::Blacklist < Crecto::Model
  schema "blacklists", primary_key: true do
    field :id, Int32, primary_key: true
    field :chat_id, String
    field :word, String
  end

  validate_required [:chat_id, :word]
  validate_length :word, min: 3

  def self.create_by(chat_id, word)
    bl = new
    bl.chat_id = chat_id.to_s
    bl.word    = word.downcase

    Repo::DB_LOGGER.info("Added #{word.downcase} to #{chat_id}")
    Repo.insert(bl)
  end

  def self.delete(bl)
    Repo.delete(bl)
  end

  def self.by_msg_and_word(msg, word)
    Repo.all(Blacklist, Query.new.where(chat_id: msg.chat.id, word: word.downcase))
  end

  def self.by(**params)
    Repo.all(Blacklist, Query.new.where(**params))
  end
end