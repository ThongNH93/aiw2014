ActiveAdmin.register Province do
  permit_params :name ,:area_id

  form(:html => { :multipart => true }) do |f|
    f.inputs "Location" do
      f.input :area_id, :as => :select,  :collection => Area.all
      f.input :name, label: "Tiêu đề"
    end
    f.actions
  end
end
