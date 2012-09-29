class List < ActiveRecord::Base  
  attr_accessible :deadline, :name
  
  belongs_to :user
  
  
  
end
