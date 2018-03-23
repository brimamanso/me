# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180302193255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "cans", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_chats_on_recipient_id"
    t.index ["sender_id"], name: "index_chats_on_sender_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "post_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comment_html"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "author_id"
    t.integer "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id", "receiver_id"], name: "index_conversations_on_author_id_and_receiver_id", unique: true
    t.index ["author_id"], name: "index_conversations_on_author_id"
    t.index ["receiver_id"], name: "index_conversations_on_receiver_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "event_datetime"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "faqs", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.string "followable_type", null: false
    t.bigint "followable_id", null: false
    t.string "follower_type", null: false
    t.bigint "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["followable_type", "followable_id"], name: "index_follows_on_followable_type_and_followable_id"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
    t.index ["follower_type", "follower_id"], name: "index_follows_on_follower_type_and_follower_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "hash_tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailboxer_conversation_opt_outs", id: :serial, force: :cascade do |t|
    t.string "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"
  end

  create_table "mailboxer_conversations", id: :serial, force: :cascade do |t|
    t.string "subject", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailboxer_notifications", id: :serial, force: :cascade do |t|
    t.string "type"
    t.text "body"
    t.string "subject", default: ""
    t.string "sender_type"
    t.integer "sender_id"
    t.integer "conversation_id"
    t.boolean "draft", default: false
    t.string "notification_code"
    t.string "notified_object_type"
    t.integer "notified_object_id"
    t.string "attachment"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.boolean "global", default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
    t.index ["notified_object_type", "notified_object_id"], name: "mailboxer_notifications_notified_object"
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
    t.index ["type"], name: "index_mailboxer_notifications_on_type"
  end

  create_table "mailboxer_receipts", id: :serial, force: :cascade do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.integer "notification_id", null: false
    t.boolean "is_read", default: false
    t.boolean "trashed", default: false
    t.boolean "deleted", default: false
    t.string "mailbox_type", limit: 25
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_delivered", default: false
    t.string "delivery_method"
    t.string "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"
  end

  create_table "mails", force: :cascade do |t|
    t.text "body"
    t.bigint "talk_id"
    t.bigint "user_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["talk_id"], name: "index_mails_on_talk_id"
    t.index ["user_id"], name: "index_mails_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "chat_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "notified_by_id"
    t.bigint "post_id"
    t.bigint "follow_id"
    t.integer "identifier"
    t.string "notice_type"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follow_id"], name: "index_notifications_on_follow_id"
    t.index ["notified_by_id"], name: "index_notifications_on_notified_by_id"
    t.index ["post_id"], name: "index_notifications_on_post_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "personal_messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_personal_messages_on_conversation_id"
    t.index ["user_id"], name: "index_personal_messages_on_user_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.text "content", null: false
    t.integer "user_id"
    t.string "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "cached_votes_up", default: 0
    t.integer "comments_count", default: 0
    t.text "content_html"
    t.string "image"
    t.text "url"
    t.index ["cached_votes_up"], name: "index_posts_on_cached_votes_up"
    t.index ["comments_count"], name: "index_posts_on_comments_count"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "posts_cans", id: false, force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "can_id"
    t.index ["can_id"], name: "index_posts_cans_on_can_id"
    t.index ["post_id"], name: "index_posts_cans_on_post_id"
  end

  create_table "posts_hash_tags", id: false, force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "hash_tag_id"
    t.index ["hash_tag_id"], name: "index_posts_hash_tags_on_hash_tag_id"
    t.index ["post_id"], name: "index_posts_hash_tags_on_post_id"
  end

  create_table "replies", force: :cascade do |t|
    t.text "content"
    t.bigint "faq_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faq_id"], name: "index_replies_on_faq_id"
  end

  create_table "search_suggestions", force: :cascade do |t|
    t.string "term"
    t.integer "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "talks", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "about"
    t.string "avatar"
    t.string "cover"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "posts_count", default: 0, null: false
    t.string "slug"
    t.integer "sash_id"
    t.integer "level", default: 0
    t.text "bio"
    t.text "Favourite_Destinations"
    t.text "wish"
    t.text "believes"
    t.text "Friends_with_benefits"
    t.text "passions"
    t.text "Favourite_Quote"
    t.text "why_are_you_on_earth"
    t.text "Core_Values"
    t.text "strengths"
    t.text "Leadership_Styles"
    t.text "Native_Language"
    t.text "Business_Ventures"
    t.text "Allergies"
    t.text "Favourite_Time_of_sleep"
    t.text "Favourite_Books"
    t.text "Favourite_Movies"
    t.text "school_type"
    t.text "Relationship_status"
    t.text "Favourite_Footwears"
    t.text "Favourite_Brand"
    t.text "Favourite_Pet"
    t.text "Favourite_Seasons"
    t.text "Favourite_Animals"
    t.text "Favourite_University"
    t.text "Favourite_Schools"
    t.text "Favourite_Youtubers"
    t.text "Favourite_Songs"
    t.text "Favourite_Car"
    t.text "Favourite_Countries"
    t.text "Favourite_Basketball_Players"
    t.text "Favourite_Food"
    t.text "Best_Friends"
    t.text "Favourite_Roommate"
    t.text "Favourite_Professors"
    t.text "Favourite_Teachers"
    t.text "Favourite_Subjects"
    t.text "Favourite_Footballers"
    t.text "Favourite_TVshows"
    t.text "Favourite_Sports"
    t.text "Role_Model"
    t.text "Voluntering_Work"
    t.text "Experiences"
    t.text "Profession"
    t.text "School_Name"
    t.text "Accomplishments"
    t.text "Skills"
    t.text "Goals"
    t.string "Website"
    t.text "Likes"
    t.text "Interests"
    t.text "Hobies"
    t.text "phone_number"
    t.text "dob"
    t.text "Majors"
    t.text "Minors"
    t.text "location"
    t.string "sex", default: "male", null: false
    t.text "Nationality"
    t.text "Favourite_Musicians"
    t.date "date_of_birth"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "follows"
  add_foreign_key "notifications", "posts"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "notified_by_id"
  add_foreign_key "personal_messages", "conversations"
  add_foreign_key "personal_messages", "users"
  add_foreign_key "posts_cans", "cans"
  add_foreign_key "posts_cans", "posts"
  add_foreign_key "posts_hash_tags", "hash_tags"
  add_foreign_key "posts_hash_tags", "posts"
  add_foreign_key "replies", "faqs"
end
