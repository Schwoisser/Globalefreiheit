class CreateArticles < ActiveRecord::Migration
  def up
      create_table :articles do |t|
        t.string :title
        t.string :author
        t.string :image
        t.string :text
        t.string :description
        t.string :tag
      end

  end

  def down
     drop_table :articles
  end
end
