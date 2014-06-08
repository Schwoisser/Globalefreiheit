class Article < ActiveRecord::Base
  attr_accessible  :id,:title,:author,:image, :preview_image,:text,:description,:tag,:link
  self.primary_key = 'id'
  
  def image
    image = super
    if image == nil
      return id.to_s + ".jpg"
    else
      return image
    end
  end
  
  def preview_image
    image = super
    if image == nil
      return id.to_s + "_small.jpg"
    else
      return image
    end
  end
  
  def author_name
    author = Author.find_by_id(self.author)
    author.name
  end
  
end
