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
  @article =  Article.last(7).reverse!
  @slider = erb :slider, :layout => false
  puts erb :slider, :layout => false
  erb :index
end

#goto page x 
#incomplete query
get '/page/:page' do
  @page_nr = params[:page].to_i
  article = Article.last
  last_id = article.id.to_i
  from =last_id - (@page_nr*7+6)
  to =last_id - (@page_nr*7)
  @article = Article.find((from..to).to_a).reverse!
  
  @slider = erb :slider, :layout => false

  erb :index
end

get '/article/:title' do
  @article = Article.find_by_title(params[:title])
  @slider = @article.slider
  erb :article #, (request.xhr? ? false : :layout) #just return the article without layout when its an ajax request
end

get '/author/:author_id' do
 @article = Article.where(author: params[:author_id]).order(title: :asc)
 erb :index
end

get '/rubriken/:rubrik_id' do
 rubrik_id = params[:rubrik_id].to_i
 @article = Article.find_by_sql("select * from articles
                                 inner join article_rubriks on articles.id = article_rubriks.a_id 
                                 and article_rubriks.r_id = #{rubrik_id};
                                ")
                                
 @slider = erb :slider, :layout => false
 erb :index
end

get '/rubriken' do
 @rubriken = Rubrik.all.order(:name)
 erb :rubriken
end

get '/willkommen' do
  erb :willkommen
end

get '/links' do
  erb :links
end

get '/autoren' do
  @authors = Author.all.order(:name)
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

get '/books' do
  erb :books
end



