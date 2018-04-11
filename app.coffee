AskBot = require './AskBot.coffee'
config = require './config/config.coffee'

askBot = new AskBot 
  token: config.token

do askBot.run