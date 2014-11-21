class CreateBabies < ActiveRecord::Migration
  def change
    create_table :babies do |t|
      t.integer :age
      t.references :user, index: true

      t.timestamps
    end
  end
end
