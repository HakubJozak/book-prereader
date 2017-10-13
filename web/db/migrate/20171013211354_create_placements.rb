class CreatePlacements < ActiveRecord::Migration[5.1]
  def change
    create_table :placements do |t|
      t.belongs_to :book
      t.belongs_to :word
      t.float :frequency
      t.integer :count

      t.timestamps
    end
  end
end
