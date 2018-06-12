class CreateBookSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :book_suggestions do |t|
      t.string :editorial
      t.float :price
      t.string :author
      t.string :title
      t.string :link
      t.string :publisher
      t.string :year
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
