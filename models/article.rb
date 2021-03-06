class Article < ActiveRecord::Base
  
  self.primary_key = 'id'
  has_and_belongs_to_many :rubriks,
        foreign_key: "a_id",
        join_table:  "article_rubriks",
        association_foreign_key: "r_id"

  def self.page(nr)
    article = last
    last_id = article.id.to_i
    from =last_id - (nr*7+6)
    to =last_id - (nr*7)
    find((from..to).to_a).reverse!
  end

  def self.all_for_rubrik(rubrik_id)
    find_by_sql("select * from articles
                                 inner join article_rubriks on articles.id = article_rubriks.a_id 
                                 and article_rubriks.r_id = #{rubrik_id};
                                ")
  end
  
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
