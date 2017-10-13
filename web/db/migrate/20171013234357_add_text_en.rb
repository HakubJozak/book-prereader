class AddTextEn < ActiveRecord::Migration[5.1]
  def change
    add_column :words, :text_en, :string
    add_column :words, :text_cs, :string    
  end
end
