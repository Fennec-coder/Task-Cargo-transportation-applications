class CreateCargos < ActiveRecord::Migration[6.1]
  def change
    create_table :cargos do |t|
      t.string :weight

      t.string :length
      t.string :width
      t.string :height
      t.timestamps
    end
  end
end
