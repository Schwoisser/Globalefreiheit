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

  erb :article #, (request.xhr? ? false : :layout) #just return the article without layout when its an ajax request
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
            #xml.pubDate Time.parse(post.created_at.to_s).rfc822()
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


