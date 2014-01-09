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
    :adapter => 'sqlite3',
    :database => 'db/development.sqlite3')
end



get '/' do
  @article =  Article.first(7)
  erb :index
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


get "/article/create" do
  article = Article.new
  article.title = "test"
  article.author = "test"
  article.image = "130"
  article.text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, 
    sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat,
    sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.
    Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
    Lorem ipsum dolor sit amet, consetetur sadipscing elitr, 
    sed diam nonumy eirmod tempor invidunt ut labore et dolore magna
    aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo
    dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus 
    est Lorem ipsum dolor sit amet."
  article.description = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, 
    sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat,
    sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum."
  article.tag = "test"
  article.save
      
  "created test article"
end
