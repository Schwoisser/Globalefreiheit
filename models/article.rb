class Article < ActiveRecord::Base
  attr_accessible  :title,:author,:image,:text,:description,:tag,:link
end