class Rubrik < ActiveRecord::Base
	has_and_belongs_to_many :articles,
		foreign_key: "r_id",
		join_table:  "article_rubriks",
      	association_foreign_key: "a_id"
end
