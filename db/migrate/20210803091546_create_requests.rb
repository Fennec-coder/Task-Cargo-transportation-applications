class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.string :origin_location
      t.string :destination
      t.string :distance
      t.timestamps
    end
  end
end
