class CreateCargos < ActiveRecord::Migration[6.1]
  def change
    create_table :cargos do |t|

      t.timestamps
    end
  end
end
