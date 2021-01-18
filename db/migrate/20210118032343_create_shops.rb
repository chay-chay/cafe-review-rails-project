class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.integer :rating
      t.text :address
      t.belongs_to :state
      t.belongs_to :user

      t.timestamps
    end
  end
end
