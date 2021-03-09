class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.text :name
      t.belongs_to :state
      t.belongs_to :user

      t.timestamps
    end
  end
end
