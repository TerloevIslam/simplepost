class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :headline, null: false
      t.string :body, null: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
