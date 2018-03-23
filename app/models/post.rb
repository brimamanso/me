class Post < ActiveRecord::Base
  belongs_to :user
  counter_culture :user
  acts_as_votable
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy 

  include PublicActivity::Model
  tracked only: [:create, :like], owner: proc { |_controller, model| model.user }

  default_scope -> { order('created_at DESC') }

  mount_uploader :attachment, AvatarUploader
  mount_uploader :image, ImageUploader

  validates_presence_of :content
  validates :user_id, presence: true

  def comment_count
    comments.length
  end 

  def self.search(params)
    posts = Post.where("content LIKE?", "%#{params[:search]}%") if params[:search].present?
    posts 
  end 
end