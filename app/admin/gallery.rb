ActiveAdmin.register Gallery do

  permit_params :image

  form(:html => { :multipart => true }) do |f|
    f.inputs "Gallery Image" do
      f.input :image, label:"Hình ảnh", :as => :file
      f.hidden_field :image_cache
      f.check_box :remove_image
    end
    f.actions
  end
end
