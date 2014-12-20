class Province < ActiveRecord::Base
  belongs_to :area
  has_many :locations

  searchable do
    text :name
  end
end
