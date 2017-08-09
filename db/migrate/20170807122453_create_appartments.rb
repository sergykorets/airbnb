class CreateAppartments < ActiveRecord::Migration[5.1]
  def change
    create_table :appartments do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.float :rent
      t.integer :author_id, index: true
      t.float :earning
      t.float :profit

      t.timestamps
    end
  end
end
