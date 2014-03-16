class Article < ActiveRecord::Base
  attr_accessible  :id,:title,:author,:image, :preview_image,:text,:description,:tag,:link
  
  
  def self.page (page_nr)
      article = last(2)
      last_id = article.first.ID.to_i
      article = find( ((last_id - (page_nr*7))..(last_id - (page_nr*7+7))).to_a )
  end
  
  def image
    image = super
    if image == nil
      return id + ".jpg"
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
