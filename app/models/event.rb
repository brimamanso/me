
class Event < ActiveRecord::Base
    belongs_to :user
    acts_as_votable
    
  
    include PublicActivity::Model
    tracked only: [:create, :like], owner: Proc.new{ |controller, model| model.user }
  
    validates_presence_of :name
    validates_presence_of :event_datetime
    validates_presence_of :user
end