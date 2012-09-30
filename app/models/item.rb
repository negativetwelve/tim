class Item < ActiveRecord::Base
  attr_accessible :deadline, :description, :isdone, :name, :priority, :index
  belongs_to :list
  
end
