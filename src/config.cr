struct TBot::Config
  TOTEM       = Totem.from_file("./config.yaml")
  BOT_KEY     = TOTEM.get("bot_api_key").as_s
  DB_LOCATION = TOTEM.get("database.file").as_s
end
