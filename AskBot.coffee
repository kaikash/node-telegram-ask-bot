TelegramBot = require 'node-telegram-bot-api'
helpers = require './helpers.coffee'


class AskBot
  constructor: (@options) ->
    @token = @options.token
    @bot = new TelegramBot @token, 
      polling: true

AskBot::initListeners = ->
  @bot.on 'message', (msg) =>
    try
      if msg.text
        @handleTextMessage msg
      else
        @unknownCommand msg
    catch err
      console.error err

AskBot::run = ->
  do @initListeners

AskBot::handleTextMessage = (msg) ->
  switch msg.text
    when '/start'
      @bot.sendMessage msg.chat.id, helpers.getMessage('hello', 
        username: msg.from.username
      ), @getDefaultKeyboard()
    when 'Pick up'
      @bot.sendMessage msg.chat.id, helpers.getMessage('pickUp'), @getDefaultKeyboard()
    when 'Random question'
      @bot.sendMessage msg.chat.id, helpers.getMessage('randomQuestion'), @getDefaultKeyboard()
    else
      @unknownCommand msg

AskBot::getDefaultKeyboard = -> 
  reply_markup: 
    keyboard: [['Random question'], ['Pick up']]

AskBot::unknownCommand = (msg) -> 
  @bot.sendMessage msg.chat.id, helpers.getMessage 'unkownCommand', @getDefaultKeyboard()

module.exports = AskBot