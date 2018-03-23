class CreateCans < ActiveRecord::Migration[5.1]
  def change
    create_table :cans do |t|
      t.string :name

      t.timestamps
    end
  end
end
