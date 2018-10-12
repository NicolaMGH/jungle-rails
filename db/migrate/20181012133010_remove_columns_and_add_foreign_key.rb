class RemoveColumnsAndAddForeignKey < ActiveRecord::Migration
  def change
    remove_column :reviews, :user_id, :integer
    remove_column :reviews, :product_id, :integer
    add_column :reviews, :product_id, :integer
    add_column :reviews, :user_id, :integer
    add_foreign_key :reviews, :products
    add_foreign_key :reviews, :users
  end
end
