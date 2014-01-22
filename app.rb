require 'sinatra'
require 'protected_attributes'
require "active_record"
require "sinatra/activerecord"

require './models/article'


set :environment, :production
set :port, 80
set :database, 'sqlite3:///development.sqlite3.db'

configure do
  ActiveRecord::Base.establish_connection(
    :adapter  => "mysql2",
    :host     => "localhost",
    :username => "test",
    :password => "test",
    :database => "Globalefreiheit"
  )
end



get '/' do
  @article =  Article.last(7)
  erb :index
end

#goto page x 
#incomplete query
get '/page/:page' do
  @pagenumber = params[:page].to_i - 1
  @article = Article.last(1)
  @last_id = @article.first.ID.to_i
  @article = Article.where("ID > ? AND ID < ?", @last_id - (@pagenumber*7) ,@last_id - (@pagenumber*7+7) )
  erb :article
end

get '/article/:title' do
  @article = Article.find_by_title(params[:title])
  erb :article #, (request.xhr? ? false : :layout) #just return the article without layout when its an ajax request
end


get '/willkommen' do
  erb :willkommen
end

get '/links' do
  erb :links
end

get '/autoren' do
  erb :autoren
end

get '/partner' do
  erb :partner
end

get '/veranstaltungen' do
  erb :veranstaltungen
end

get '/commu' do
  erb :commu
end

get '/bitcoins' do
  erb :bitcoins
end

get '/impressum' do
  erb :impressum
end

get '/videos' do
  erb :videos
end

get '/musik' do
  erb :musik
end

put '/article/:title' do
  
end



