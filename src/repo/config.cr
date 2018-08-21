module Repo
  extend Crecto::Repo
  DB_LOGGER = Logger.new(STDOUT, level: Logger::DEBUG)

  config do |conf|
    conf.adapter = Crecto::Adapters::SQLite3
    conf.database = TBot::Config::DB_LOCATION
  end
end

# shortcut variables, optional
Query = Crecto::Repo::Query
Multi = Crecto::Multi

require "./blacklist"
require "./user"