class CreateCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    add_column :posts, :category_id, :integer
  end
end
