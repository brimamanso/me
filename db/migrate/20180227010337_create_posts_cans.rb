class CreatePostsCans < ActiveRecord::Migration[5.1]
  def change
    create_table :posts_cans, :id => false do |t|
      t.references :post,  index: true, foreign_key: true
      t.references :can,  index: true, foreign_key: true
    end
  end
end
