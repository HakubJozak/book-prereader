class AddKnownToWords < ActiveRecord::Migration[5.1]
  def change
    add_column :words, :known, :boolean
  end
end
