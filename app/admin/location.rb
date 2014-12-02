ActiveAdmin.register Location do
   permit_params :name, :description, :province_id,:image,:content

   form(:html => { :multipart => true }) do |f|
       f.inputs "Location" do
         f.input :province_id, :as => :select,  :collection => Province.all
         f.input :name, label: "Tiêu đề"
         f.input :description, label: "Tóm tắt"
         f.input :content, label: "Nội dung", input_html: {class: 'ckeditor'}
         f.input :image, label:"Hình ảnh", :as => :file
       end
      f.actions
   end
end
