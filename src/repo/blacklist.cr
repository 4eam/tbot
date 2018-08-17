class Blacklist < Crecto::Model

  schema "blacklist" do
    field :group_id, Int32 # or use `PkeyValue` alias: `field :age, PkeyValue`
    field :word, String
  end

  validate_required [:group_id, :word]
end