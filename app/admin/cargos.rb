ActiveAdmin.register Cargo do
  permit_params :weight, :length, :width, :height, :request_id

  index do
    selectable_column
    id_column
    column :weight
    column :length
    column :width
    column :height
    column :created_at
    column :request_id
    actions
  end

  filter :request_id
  filter :weight

  form do |f|
    f.inputs do
      f.input :weight
      f.input :length
      f.input :width
      f.input :height
      f.input :request_id
    end
    f.actions
  end

end
