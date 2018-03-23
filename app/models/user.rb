class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  acts_as_voter
  acts_as_follower
  acts_as_followable

  has_many :personal_messages, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, AvatarUploader
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :talks, :foreign_key => :sender_id


  after_create :create_default_chat
  

  validates_presence_of :name
  include PgSearch
  pg_search_scope :search_by_full_name, against: [:name] 

  def self.search(params)
    users = User.where("name LIKE?", "%#{params[:search]}%") if params[:search].present?
    users 
  end


  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  acts_as_messageable 

    def mailboxer_name
      self.name
    end

    def mailboxer_email(object)
      self.email
    end

    private

  # for demo purposes

    def create_default_conversation
      Conversation.create(sender_id: 1, recipient_id: self.id) unless self.id == 1
    end
end