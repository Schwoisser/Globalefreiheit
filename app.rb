#!/usr/bin/env ruby
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
 
#  dbconfig = YAML::load(File.open('config/database.yml'))
#  puts dbconfig
#  ActiveRecord::Base.establish_connection(dbconfig["production"])
 #   enable :logging
 #   set :dump_errors, false
#    Dir.mkdir('log') unless File.exist?('log')

#    $logger = Logger.new('log/production.log','weekly')
#    $logger.level = Logger::WARN

    # Spit stdout and stderr to a file during production
    # in case something goes wrong
#    $stdout.reopen("log/production.log", "w")
#    $stdout.sync = true
#    $stderr.reopen($stdout)
end



get '/' do
  @article =  Article.last(7).reverse!
  @slider = erb :slider, :layout => false
  erb :index
end

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
   @slider = erb :books_slider, :layout => false
  erb :books
end

#rss feed

get '/rss.xml' do
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
            xml.pubDate Time.parse(post.created_at.to_s).rfc822()
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


