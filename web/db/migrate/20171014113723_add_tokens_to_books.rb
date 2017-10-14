class AddTokensToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :tokens, :json
  end
end
