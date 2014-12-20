class Area < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :provinces
  has_many :places, :through => :provinces, :source => :locations
end
