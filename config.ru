#required for railshoster deployment
# config.ru
require 'sinatra'
require './app'
run Sinatra::Application
# End config.ru
