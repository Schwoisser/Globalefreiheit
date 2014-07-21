#required for railshoster deployment
# config.ru
require 'sinatra'
require './app'
require 'rubygems'
require 'bundler'

Bundler.require

run Sinatra::Application
# End config.ru
