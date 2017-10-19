class AddGoogleResults < ActiveRecord::Migration[5.1]
  def change
    add_column :words, :google_results, :integer, limit: 8
  end
end
