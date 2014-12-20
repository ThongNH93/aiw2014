ActiveAdmin.register TopImage do

  permit_params :image

  form(:html => { :multipart => true }) do |f|
    f.inputs "Gallery Image" do
      f.input :image, label:"Hình ảnh", :as => :file
    end
    f.actions
  end

end
