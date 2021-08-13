class CreateCargos < ActiveRecord::Migration[6.1]
  def change
    create_table :cargos do |t|
      t.float :weight
      t.float :length
      t.float :width
      t.float :height
      t.timestamps
    end
    add_reference :cargos, :request, foreign_key: true
  end
end
