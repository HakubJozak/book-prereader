class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :source
      t.string :name

      t.timestamps
    end
  end
end
