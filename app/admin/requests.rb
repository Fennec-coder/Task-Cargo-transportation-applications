ActiveAdmin.register Request do
  permit_params :origin_location, :destination

  index do
    selectable_column
    id_column
    column :origin_location
    column :destination
    column :distance
    column :created_at
    actions
  end

  filter :origin_location
  filter :destination

  form do |f|
    f.inputs do
      f.input :origin_location
      f.input :destination
    end
    f.actions
  end

end
