class TopImage < ActiveRecord::Base
  include Rails.application.routes.url_helpers # neeeded for _path helpers to work in models
  mount_uploader :image, ImageUploader

  validates_presence_of :image
  validates_uniqueness_of :image
end
