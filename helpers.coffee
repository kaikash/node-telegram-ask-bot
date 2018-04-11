messages = require './config/messages.coffee'

getMessage = (message, extra = {}) ->
  ret = messages[message]
  if message == 'pickUp'
    return messages['pickUps'][Math.floor Math.random() * messages['pickUps'].length]
  if message == 'randomQuestion'
    return messages['randomQuestions'][Math.floor Math.random() * messages['randomQuestions'].length]
  unless ret then return "Default message"

  for key of extra
    ret = ret.replace "{{#{key}}}", extra[key]

  ret

module.exports = 
  getMessage: getMessage