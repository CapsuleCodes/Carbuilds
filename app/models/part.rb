class Part < ActiveRecord::Base
    validates_presence_of :name, :price
    belongs_to :build
    
end