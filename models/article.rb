class Article < ActiveRecord::Base
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
