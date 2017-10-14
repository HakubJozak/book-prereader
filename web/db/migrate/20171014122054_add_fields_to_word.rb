class AddFieldsToWord < ActiveRecord::Migration[5.1]
  def change
    add_column :words, :dictionary_id, :integer
    add_column :words, :corpus_frequency, :integer    
  end
end
