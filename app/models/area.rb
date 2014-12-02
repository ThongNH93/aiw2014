class Area < ActiveRecord::Base
  has_many :provinces
  has_many :places, :through => :provinces, :source => :locations
end
