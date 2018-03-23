class CreateMails < ActiveRecord::Migration[5.1]
  def change
    create_table :mails do |t|
      t.text :body
      t.references :talk, index: true
      t.references :user, index: true
      t.boolean :read, :default => false
      t.timestamps
    end
  end
end
