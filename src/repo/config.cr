module TBot
  Query = Crecto::Repo::Query
  Multi = Crecto::Multi
  
  module Repo
    extend Crecto::Repo
    DB_LOGGER = Logger.new(STDOUT, level: Logger::DEBUG)
  
    config do |conf|
      conf.adapter = Crecto::Adapters::SQLite3
      conf.database = TBot::Config::DB_LOCATION
    end
  end
end

require "./blacklist"
require "./user"