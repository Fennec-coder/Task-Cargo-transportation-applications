class AddMoreFieldsToClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :name, :string
    add_column :clients, :surname, :string
    add_column :clients, :patronymic, :string
    add_column :clients, :phone_number, :string
  end
end
