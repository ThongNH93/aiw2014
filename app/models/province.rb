class Province < ActiveRecord::Base
  belongs_to :area
  has_many :locations

  validates_presence_of :name
  validates_uniqueness_of :name

  searchable  :auto_index => true, :auto_remove => true do
    string :name
  end
end
