require 'sinatra'
require 'protected_attributes'
require "active_record"
require "sinatra/activerecord"

require './models/article'
require './models/author'
require './models/rubrik'
require './models/article_rubrik'

set :environment, :production
set :port, 80

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
  @article.each do |article|
    #check ob bild null ist dann entweder default articleID.jpg oder nach datenbank
  end
  erb :index
end

#goto page x 
#incomplete query
get '/page/:page' do
  @page_number = params[:page].to_i - 1
  @article = Article.page @page_number
  erb :index
end

get '/article/:title' do
  @article = Article.find_by_title(params[:title])
  erb :article #, (request.xhr? ? false : :layout) #just return the article without layout when its an ajax request
end

get '/author/:author_id' do
 @article = Article.where(author: params[:author_id])
 erb :index
end

get '/rubriken' do
 @rubriken = Rubrik.all
 erb :rubriken
end

get '/willkommen' do
  erb :willkommen
end

get '/links' do
  erb :links
end

get '/autoren' do
  @authors = Author.all
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



