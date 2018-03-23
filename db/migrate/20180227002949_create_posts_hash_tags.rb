class CreatePostsHashTags < ActiveRecord::Migration[5.1]
  def change
    create_table :posts_hash_tags, :id => false do |t|
      t.references :post, index: true, foreign_key: true
      t.references :hash_tag,  index: true, foreign_key: true
    end
  end
end
