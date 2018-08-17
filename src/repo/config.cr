module SqliteRepo
  extend Crecto::Repo

  config do |conf|
    conf.adapter = Crecto::Adapters::SQLite3
    conf.database = "database.db"
  end
end

# shortcut variables, optional
Query = Crecto::Repo::Query
Multi = Crecto::Multi

require "./blacklist"