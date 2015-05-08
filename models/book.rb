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
end

