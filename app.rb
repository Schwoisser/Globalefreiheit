#!/usr/bin/env ruby
# encoding: UTF-8
require 'sinatra'
require 'active_record'
require 'sinatra/activerecord'
require './models/article'
require './models/author'
require './models/rubrik'
require './models/article_rubrik'
require './models/book'


set :environment, :production
#set :port, 80


configure do
 #sinatra activerecord does the db connection for us
end

get '/' do
  @article =  Article.last(7).reverse!
  @older_article_link = true
  @slider = erb :slider, :layout => false
  erb :index
end

get '/page/:page' do
  @page_nr = params[:page].to_i
  @article = Article.page @page_nr
  @older_article_link = true
  @slider = erb :slider, :layout => false

  erb :index
end

get '/article/:id' do
  @article = Article.find_by_id(params[:id])
  @slider = @article.slider
  @rubriks = []
  article_rubriks = @article.rubriks
  @rubriks =  article_rubriks if article_rubriks
  
  erb :article #,:layout => (request.xhr? ? false : :layout) #just return the article without layout when its an ajax request
end

get '/author/:author_id' do

 

 author_id = params[:author_id].to_i
 @older_article_link = false
 @article = Article.where(author: author_id).order(title: :asc)
 @slider = erb :slider, :layout => false
 erb :index
end

get '/rubriken/:rubrik_id' do


 rubrik_id = params[:rubrik_id].to_i
 @article = Article.all_for_rubrik rubrik_id
 @older_article_link = false
 @slider = erb :slider, :layout => false

 erb :index
end

get '/rubriken' do
  @image = "8.jpg"
  @slider = erb :single_slider, :layout => false
  @rubriken = Rubrik.all.order(:name)

 erb :rubriken
end

get '/podcasts' do
  @image = "hallo.jpg"
  @slider = erb :single_slider, :layout => false

  erb :podcasts
end

get '/links' do
  @image = "earthlights.jpg"
  @slider = erb :single_slider, :layout => false

  erb :links
end

get '/autoren' do
  @image = "helden.jpg"
  @slider = erb :single_slider, :layout => false

  @authors = Author.all.order(:name)

  erb :autoren
end

get '/partner' do
  @image = "11.jpg"
  @slider = erb :single_slider, :layout => false
  erb :partner
end

get '/veranstaltungen' do
  @image = "23.jpg"
  @slider = erb :single_slider, :layout => false
  erb :veranstaltungen
end

get '/veranstaltungen.htm' do
  @image = "23.jpg"
  @slider = erb :single_slider, :layout => false
  erb :veranstaltungen
end

get '/commu' do
  @image = "45.jpg"
  @slider = erb :single_slider, :layout => false
  erb :commu
end

get '/bitcoins' do
  @image = "33.jpg"
  @slider = erb :single_slider, :layout => false
  erb :bitcoins
end

get '/impressum' do
  @image = "hallo.jpg"
  @slider = erb :single_slider, :layout => false
  erb :impressum
end

get '/videos' do
  @image = "262.jpg"
  @slider = erb :single_slider, :layout => false

  erb :videos
end

get '/musik' do
  @image = "55.jpg"
  @slider = erb :single_slider, :layout => false

  erb :musik
end

get '/faq' do
  @image = "202.jpg"
  @slider = erb :single_slider, :layout => false
  erb :faq
end

get '/books' do
   @books = Book.all.order(:author)
   @slider = erb :books_slider, :layout => false
  erb :books
end

get "/index.php" do
  redirect to('/')
end


#rss feed

get '/feed/' do
  @articles =  Article.last(21).reverse!
  link = "http://www.globalefreiheit.de/"
  builder do |xml|
  xml.instruct! :xml, :version => '1.0'
  xml.rss :version => "2.0" do
    xml.channel do
      xml.title "Globalefreiheit"
        xml.description "für alle Menschen auf der Welt"
        xml.link link
        @articles.each do |post|
          xml.item do
            xml.title post.title
            xml.link link + "article/#{post.id}"
            xml.description post.description
            xml.pubDate Time.now.to_s
            xml.guid link+"article/#{post.id}"
          end
        end
      end
    end
  end
end

after do
  # Close the connection after the request is done so that we don't
  # deplete the ActiveRecord connection pool.
  ActiveRecord::Base.connection.close
end


