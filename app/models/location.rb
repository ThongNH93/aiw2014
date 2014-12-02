class Location < ActiveRecord::Base
  include Rails.application.routes.url_helpers # neeeded for _path helpers to work in models
  mount_uploader :image, ImageUploader

  validates_presence_of :name, :image, :description, :content
  validates_uniqueness_of :name
  belongs_to :province
end
