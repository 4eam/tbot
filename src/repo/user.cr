class User < Crecto::Model
  schema "users", primary_key: true do
    field :id, Int32, primary_key: true
    field :user_id, Int32
    field :chat_id, String
    field :username, String
  end

  validate_required [:user_id, :username, :chat_id]
  validate_length :username, min: 2

  def self.create_from(user_id, chat_id, username)
    u = User.new
    u.user_id  = user_id
    u.chat_id  = chat_id.to_s
    u.username = username
    Repo::DB_LOGGER.info("Added #{user_id} from #{chat_id}")
    Repo.insert(u)
  end

  def self.delete_by(user_id, chat_id, username)
    Repo::DB_LOGGER.info("Deleted #{user_id} from #{chat_id}")
    Repo.delete_all(
      User, 
      Query.where(
        username: username, 
        user_id: user_id, 
        chat_id: chat_id.to_s
      )
    )
  end
end