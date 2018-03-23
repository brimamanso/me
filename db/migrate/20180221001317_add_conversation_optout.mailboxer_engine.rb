# This migration comes from mailboxer_engine (originally 20131206080416)
class AddchatOptout < ActiveRecord::Migration[4.2]
  def self.up
    create_table :mailboxer_chat_opt_outs do |t|
      t.references :unsubscriber, :polymorphic => true
      t.references :chat
    end
    add_foreign_key "mailboxer_chat_opt_outs", "mailboxer_chats", :name => "mb_opt_outs_on_chats_id", :column => "chat_id"
  end

  def self.down
    remove_foreign_key "mailboxer_chat_opt_outs", :name => "mb_opt_outs_on_chats_id"
    drop_table :mailboxer_chat_opt_outs
  end
end
