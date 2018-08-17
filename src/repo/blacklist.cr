class Blacklist < Crecto::Model

  schema "blacklists", primary_key: true do
    field :id, Int32, primary_key: true
    field :chat_id, String
    field :word, String
  end

  validate_required [:chat_id, :word]
  validate_length :word, min: 3
end