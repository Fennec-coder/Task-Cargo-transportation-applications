class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.string :origin_location
      t.string :destination
      t.float :distance
      t.timestamps
    end

    add_reference :requests, :client, foreign_key: true
  end
end
