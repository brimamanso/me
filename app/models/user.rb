class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  acts_as_voter
  acts_as_follower
  acts_as_followable


  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, AvatarUploader
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :talks, :foreign_key => :sender_id


  after_create :create_default_chat
  

  validates_presence_of :name

  def self.search(params)
    users = User.where("name LIKE?", "%#{params[:search]}%") if params[:search].present?
    users 
  end


  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

 
end