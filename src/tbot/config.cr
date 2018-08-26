struct TBot::Config
  TOTEM       = Totem.from_file("./.tbot.yml")
  BOT_KEY     = TOTEM.get("bot_api_key").as_s
  BOT_NAME    = TOTEM.get("bot_name").as_s
  DB_LOCATION = TOTEM.get("database.file").as_s
end
