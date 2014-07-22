#!/usr/bin/env ruby
# encoding: UTF-8
require 'sinatra'
require 'active_record'
require 'sinatra/activerecord'
require './models/article'
require './models/author'
require './models/rubrik'
require './models/article_rubrik'


set :environment, :production
set :port, 80


configure do
 #sinatra activerecord does the db connection for us
end

get '/' do
  @article =  Article.last(7).reverse!
  @slider = erb :slider, :layout => false
  erb :index
end

get '/page/:page' do
  @page_nr = params[:page].to_i
  @article = Article.page @page_nr

  @slider = erb :slider, :layout => false

  erb :index
end

get '/article/:id' do
  @article = Article.find_by_id(params[:id])
  @slider = @article.slider
  @rubriks = []
  article_rubriks = @article.rubriks
  @rubriks =  article_rubriks if article_rubriks
  puts @rubriks
  erb :article #,:layout => (request.xhr? ? false : :layout) #just return the article without layout when its an ajax request
end

get '/author/:author_id' do
 @article = Article.where(author: params[:author_id]).order(title: :asc)

 erb :index
end

get '/rubriken/:rubrik_id' do
 rubrik_id = params[:rubrik_id].to_i
 @article = Article.all_for_rubrik rubrik_id

 @slider = erb :slider, :layout => false

 erb :index
end

get '/rubriken' do
 @rubriken = Rubrik.all.order(:name)

 erb :rubriken
end

get '/willkommen' do
  @image = "hallo.jpg"
  @slider = erb :single_slider, :layout => false

  erb :willkommen
end

get '/links' do
  @image = "earth_slides.jpg"
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
  @image = "6.jpg"
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
   @slider = erb :books_slider, :layout => false
  erb :books
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


