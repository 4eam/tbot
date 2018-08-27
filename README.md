# TBot
This is awesome anti-spam Telegram bot.  
Check it in action! [DevSilenceKeeper](https://t.me/devsilencekeeper_bot)

## Setup for production
Maybe you want to use ready-to-go build. Download it in releases.  
If you want to build it yourself, then follow this steps:

- Run `shards build --release --production` to install dependencies and build.  
- Copy `.tbot.yml.example` to `.tbot.yml` and edit your Bot Key and name
- `bin/micrate up` to setup sqlite3 database    
- You are ready to run bot with `bin/DevSilenceKeeper`

## Setup for development
If you want to contribute, then:

- Install *Crystal* language with all required libraries
- Run `shards` to install required dependencies
- Copy `.tbot.yml.example` to `.tbot.yml` and edit it with your data
- `bin/micrate up` to setup sqlite DB
- You are ready to develop and contribute! Run bot with `crystal src/DevSilenceKeeper.cr`
