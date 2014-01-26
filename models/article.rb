class Article < ActiveRecord::Base
  attr_accessible  :ID,:title,:author,:image,:text,:description,:tag,:link
  
  
  def page(page_nr)
  end
  
end
