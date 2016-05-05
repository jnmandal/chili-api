class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :chili_id
      t.integer :rating_value
      t.string  :tags
      t.string  :author_email
      t.text    :comments
      t.timestamps
    end
  end
end
