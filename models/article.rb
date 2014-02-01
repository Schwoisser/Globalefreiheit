class Article < ActiveRecord::Base
  attr_accessible  :id,:title,:author,:image, :preview_image,:text,:description,:tag,:link
  
  
  def page(page_nr)
      article = last(2)
      last_id = article.first.ID.to_i
      article = where("ID < ? AND ID > ?", @last_id - (@pagenumber*7) ,@last_id - (@pagenumber*7+7) )
  end
  
  def image
    image = super
    if image == nil
      return id + ".jpg"
    else
      return image
    end
  end
  
  
  def rubrik(rubrik_name)
    
  end
  
end
