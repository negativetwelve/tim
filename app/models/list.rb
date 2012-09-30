class List < ActiveRecord::Base  
  attr_accessible :deadline, :name, :index
  
  belongs_to :user
  has_many :items
  
  validates :user_id, presence: true
  
  
  
end
