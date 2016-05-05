class CreateChilis < ActiveRecord::Migration
  def change
    create_table :chilis do |t|
      t.string :chef_name
      t.string :email
      t.string :location
      t.timestamps null: false
    end
  end
end
