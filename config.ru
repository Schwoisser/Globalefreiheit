#required for railshoster deployment
# config.ru
require 'sinatra'
require 'rubygems'
require 'bundler'

Bundler.require

require './app'
run Sinatra::Application
# End config.ru
